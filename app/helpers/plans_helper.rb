module PlansHelper

  def all_features_for_select
    Feature.all.collect { |x| [x.name, x.id] }
  end

  def plan_features(plan)
    plan.features.map(&:name).join(', ')
  end

  def pre_selected_features
    @plan.features.map(&:id)
  end
end
