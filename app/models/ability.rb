# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    # ÉQUIVALENTS: 
    # user = user || User.new
    user ||= User.new 

    
    # can :read, Post
    # cannot :read, Post

    # can [:read,:create,:update], Post # EST PLUS PERMISSIF D'ACCÉDER À TOUS AVEC 0 CONTRAINTE
    # can [:manage], Post # :manage PERMET L'ACCÈS À TOUTES LES ACTIONS (:read, :me, et meme :blablabla)
    # can [:manage], Post, {user_id: user.id} # MET EN PLUS LA CONTRAINTE DE DÉTENIR LE POST EN QUESTION

    # Method "alias_action" FOURNI PAR cancancan
    # alias_action :create, :read, :update, :delete, to: :crud
    # can [:crud,:me], Post, {user_id: user.id}


    alias_action :create, :read, :update, :destroy, to: :crud
    can [:read], Post # JE PEUX FAIRES VOIR TOUS
    if
      can [:crud], Post, {user_id: user.id} # TOUTES LES ACTIONS :crud MAIS SEULEMENT S'IL M'APPARTIENT
    end
    # if user.admin?
    #   can :manage, Post # PEUT TOUS CONSULTER ET TOUT MODIFIER CONCERNANT LES POSTS UNIUEMENT
    #   # can :manage, :all # PEUT TOUS CONSULTER ET TOUT MODIFIER CONCERNANT TOUTES DONNÉES DANS LA BDD
    # end
    














    
    # Define abilities for the user here. For example:
    #
    #   return unless user.present?
    #   can :read, :all
    #   return unless user.admin?
    #   can :manage, :all
    #
    # The first argument to `can` is the action you are giving the user
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on.
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, published: true
    #
    # See the wiki for details:
    # https://github.com/CanCanCommunity/cancancan/blob/develop/docs/define_check_abilities.md
  end
end
