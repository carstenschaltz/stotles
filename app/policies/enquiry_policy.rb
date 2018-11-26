class EnquiryPolicy < ApplicationPolicy
  def show?
    record.user == user # unless user.nil?
  end

  def show_quotes?
    record.user == user
  end

  def update?
    record.user == user # unless user.nil?
  end

  def edit
    record.user == user
  end

  def destroy?
    record.user == user # unless user.nil?
  end

  def new?
    create?
  end

  def create?
    true
  end

  class Scope < Scope
    def resolve
      scope.all
    end
  end
end
