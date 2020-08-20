class FeaturesController < ApplicationController
    
    def new
        @feature = Feature.new
    end

end
