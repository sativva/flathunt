class RegistrationsController < Devise::RegistrationsController
  skip_before_action :authenticate_user!, only: [ :home ]
  def new
    build_resource({})
    # self.resource.searches.each {|search| search = Search.new}
    # respond_with self.resource
  end

  def create
    build_resource(sign_up_params)

    resource.save
    # a = Search.create(Hash[params['user']['search']])
    # a.floor = a.floor.join(',').strip.gsub(/^,/, "")
    # a.location = a.location.join(',').strip.gsub(/^,/, "")
    # a.option = a.option.join(',').strip.gsub(/^,/, "")
    # a.save
    yield resource if block_given?
    if resource.persisted?
      if resource.active_for_authentication?
        set_flash_message! :notice, :signed_up
        sign_up(resource_name, resource)
        respond_with resource, location: after_sign_up_path_for(resource)
      else
        set_flash_message! :notice, :"signed_up_but_#{resource.inactive_message}"
        expire_data_after_sign_in!
        respond_with resource, location: after_inactive_sign_up_path_for(resource)
      end
    else
      clean_up_passwords resource
      set_minimum_password_length
      respond_with resource
    end
  end

  protected

  def after_sign_up_path_for(resource)
   user_path(current_user) # Or :prefix_to_your_route
  end

  def sign_up_params
    allow = [:email, :user_name, :search_id, :password, :password_confirmation, search_attributes: [:price, :email, :username, :user_id, :lift, :surface, :room, :bedroom, :to_renovate, :comment, :option, :location , :floor]]
    params.require(resource_name).permit(allow)
  end
end
