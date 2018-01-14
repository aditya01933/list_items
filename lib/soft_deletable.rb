module SoftDeletable
  def self.included(base)
    base.scope :not_deleted, -> { base.where(status: 'active') }
    base.send(:default_scope) { base.not_deleted }
    base.scope :only_deleted, -> { 
      base.unscope(where: :status).where(status: 'deleted')
    }

    base.define_singleton_method :soft_delete do |method_name, output|
      define_method(method_name) { output }
    end

    def delete
      process :delete, status: 'deleted'
    end

    def recover
      process :recover, status: 'active'
    end

    private

    def process(action, status:)
      transaction do
        update! status: status if has_attribute? :status
        
        if respond_to? :dependents
          dependents.each do |dependent|
            send(dependent).unscope(where: :status).each(&action)
          end
        end
      end
    end
  end
end

