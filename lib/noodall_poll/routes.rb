module NoodallPoll
  class Routes
    class << self
      def draw(app)
        app.routes.draw do

          namespace(:noodall_poll) do

            namespace(:admin) do
              match(
                'polls/new_reponse_option_form_element' => 'polls#new_response_option_form_element',
                :as => 'new_response_option_element'
              )
              resources :polls do
                member do
                  post 'reset'
                end
              end

            end

            resources :polls

          end
        end
      end
    end
  end
end
