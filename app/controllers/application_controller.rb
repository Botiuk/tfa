class ApplicationController < ActionController::Base
    include Pagy::Backend

    rescue_from CanCan::AccessDenied do |exception|
        redirect_to root_url, alert: t('alert.access_denied')
    end
end
