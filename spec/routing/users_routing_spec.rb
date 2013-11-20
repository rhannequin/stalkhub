require 'spec_helper'

describe UsersController do
  describe 'routing' do

    it 'routes to #show' do
      get('settings').should route_to('users#show')
    end

    it 'routes to #destroy' do
      delete('account/delete').should route_to('users#destroy')
    end

  end
end
