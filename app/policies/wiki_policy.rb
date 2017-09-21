class WikiPolicy < ApplicationPolicy
    class Scope
        attr_reader :user, :scope
        
        def initialize(user, scope)
            @user = user
            @scope = scope
        end
        
        def resolve
            wikis = []
            if user.role == 'admin'
                wikis = scope.all
            elsif user.role == 'premium'
                all_wikis = scope.all
                isCollaborator = false
                all_wikis.each do |wiki|
                    wiki.collaborators.each do |c|
                        if c.user.id == @user.id
                            isCollaborator = true
                        end
                    end
                    if !(wiki.private?) || wiki.user_id == @user.id || isCollaborator
                        wikis << wiki
                    end
                    isCollaborator = false
                end
            else
                all_wikis = scope.all
                wikis = []
                isCollaborator = false
                all_wikis.each do | wiki|
                    wiki.collaborators.each do |c|
                        if c.user.id == @user.id
                            isCollaborator = true
                        end
                    end
                    if !(wiki.private?) || isCollaborator
                        wikis << wiki
                    end
                    isCollaborator = false
                end
            end
            
            wikis
        end
    end     
end