class GroupsController < ApplicationController
   before_filter :find_group, :only => [:show, :destroy]

   def index
     @groups = Forem::Group.all
   end

   def new
     @group = Forem::Group.new
   end

   def create
     @group = Forem::Group.new(group_params)
     if @group.save
       user = Forem.user_class.where(:id => current_user.id).first
       @group.members << user
       @category = Forem::Category.find_by(name: current_user.neighborhood_id)
       newSubOne = Forem::Forum.new
       newSubOne.title = @group.name
       newSubOne.description = @group.description
       newSubOne.category_id = @category.id
       newSubOne.group_id = @group.id
       newSubOne.position = 12
       newSubOne.save
       flash[:notice] = t("forem.admin.group.created")
       redirect_to groups_path
     else
       flash[:alert] = t("forem.admin.group.not_created")
       render :new
     end
   end

   def destroy
     Forem::Membership.all.where(:group_id => @group.id).destroy_all
     @group.destroy
     flash[:notice] = t("forem.admin.group.deleted")
     redirect_to  main_app.root_path
   end

   private

     def find_group
       @group = Forem::Group.find(params[:id])
     end

     def group_params
       params.require(:group).permit(:name, :description)
     end
 end
