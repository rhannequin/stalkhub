class StalkingsController < ApplicationController
  before_filter :is_logged?

  # GET /stalkings
  # GET /stalkings.json
  def index
    @stalkings = Stalking.where("user_id = ?", current_user.id)
    @stalkings.each do |stalking|
      if @current_user.gh.repository? "#{stalking.owner}/#{stalking.repo}"
        stalking.gh = @current_user.gh.repo "#{stalking.owner}/#{stalking.repo}"
      else
        stalking.gh = "#{stalking.owner}/#{stalking.repo}"
      end
    end

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @stalkings }
    end
  end

  # GET /stalkings/1
  # GET /stalkings/1.json
  def show
    @stalking = Stalking.find(params[:id])
    @require_js[:script] = 'views/StalkingView'
    @require_js[:params][:stalking] = @stalking

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @stalking }
    end
  end

  # GET /stalkings/new
  # GET /stalkings/new.json
  def new
    @stalking = Stalking.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @stalking }
    end
  end

  # GET /stalkings/1/edit
  def edit
    @stalking = Stalking.find(params[:id])
  end

  # POST /stalkings
  # POST /stalkings.json
  def create
    @stalking = Stalking.new(app_params)
    @stalking.user_id = current_user.id

    respond_to do |format|
      if @stalking.save
        format.html { redirect_to @stalking, flash: { success: 'Stalking was successfully created.' } }
        format.json { render json: @stalking, status: :created, location: @stalking }
      else
        format.html { render action: "new" }
        format.json { render json: @stalking.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /stalkings/1
  # PUT /stalkings/1.json
  def update
    @stalking = Stalking.find(params[:id])
    @stalking.user_id = current_user.id

    respond_to do |format|
      if @stalking.update_attributes(app_params)
        format.html { redirect_to @stalking, flash: { success: 'Stalking was successfully updated.' } }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @stalking.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /stalkings/1
  # DELETE /stalkings/1.json
  def destroy
    @stalking = Stalking.find(params[:id])
    @stalking.destroy

    respond_to do |format|
      format.html { redirect_to stalkings_url, flash: { success: 'Stalking was successfully destroyed.' } }
      format.json { head :no_content }
    end
  end

  private
    def app_params
      params.require(:stalking).permit(:user_id, :owner, :repo, :last_commit_seen)
    end
end
