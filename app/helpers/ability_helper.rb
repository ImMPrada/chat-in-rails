module AbilityHelper
  def can?(workspace, action, resource)
    Ability.new(current_user, workspace).can?(action, resource)
  end
end
