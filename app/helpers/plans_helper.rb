module PlansHelper
  def plan_features(plan)
    plan.features.map(&:name).join(', ')
  end

  def pre_selected_features(plan)
    plan.features.map(&:id)
  end
end
