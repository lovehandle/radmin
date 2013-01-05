module Radmin
  module Helpers
    module Resource

      def panel(title, locals = {}, &block)
        block_to_partial "radmin/panel", locals.merge(title: title), &block
      end

      def sidebars(&block)
        content_for :sidebars, &block
      end

      def resource_form(options = {}, &block)
        simple_form_for resource, builder: Radmin::View::FormBuilder do |f|
          f.instance_eval(&block)
        end
      end

      def resource_fields_for(model_name, &block)
        simple_fields_for model_name, builder: Radmin::View::FormBuilder do |f|
          f.instance_eval(&block)
        end
      end

      def form(locals = {}, &block)
        form_block = lambda {
          resource_form(&block)
        }

        block_to_partial("radmin/form", locals, &form_block)
      end

      def table_for
        raise "FUCK"
      end

      protected

      def block_to_partial(partial_name, locals = {}, &block)
        render partial_name, locals.merge({ body: capture(&block) })
      end

    end # module Resources
  end # module Helpers
end # module Radmin
