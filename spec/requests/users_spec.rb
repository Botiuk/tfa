# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Users' do
  describe 'non registered user management' do
    it 'cannot GET index and redirects to the sign_in page' do
      get users_path
      expect(response).to redirect_to(new_user_session_path)
      expect(flash[:alert]).to include I18n.t('devise.failure.unauthenticated')
    end

    it 'cannot GET search and redirects to the sign_in page' do
      get admin_users_search_path
      expect(response).to redirect_to(new_user_session_path)
      expect(flash[:alert]).to include I18n.t('devise.failure.unauthenticated')
    end
  end

  describe 'register user (not admin) management' do
    before do
      user = create(:user, role: %w[user fan].sample)
      login_as(user, scope: :user)
    end

    it 'cannot GET index and redirects to the root page' do
      get users_path
      expect(response).to redirect_to(root_path)
      expect(flash[:alert]).to include I18n.t('alert.access_denied')
    end

    it 'cannot GET search and redirects to the root page' do
      get admin_users_search_path
      expect(response).to redirect_to(root_path)
      expect(flash[:alert]).to include I18n.t('alert.access_denied')
    end
  end

  describe 'user-admin management' do
    before do
      user = create(:user, role: 'admin')
      login_as(user, scope: :user)
    end

    it 'can GET index' do
      get users_path
      expect(response).to be_successful
    end

    it 'can PUT update' do
      user = create(:user, role: 'user')
      put user_path(user), params: { user: { role: 'fan' } }
      expect(user.reload.role).to eq('fan')
      expect(response).to redirect_to(users_path)
      expect(flash[:notice]).to include(I18n.t('notice.update.user_role'))
    end

    it 'can GET search' do
      get admin_users_search_path(email: 'abc')
      expect(response).to be_successful
    end

    it 'cannot GET empty search and redirect to index page' do
      get admin_users_search_path
      expect(response).to redirect_to(users_path)
      expect(flash[:alert]).to include(I18n.t('alert.search.user'))
    end
  end
end
