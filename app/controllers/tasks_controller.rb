class TasksController < ApplicationController
  before_action :set_task, only: %i[ show edit update destroy ]

  # GET /tasks or /tasks.json
  def index
    @tasks = Task.all
  end

  # GET /tasks/1 or /tasks/1.json
  def show
  end

  # GET /tasks/new
  def new
    auth_guard
    @task = Task.new
  end

  # GET /tasks/1/edit
  def edit
  end

  # POST /tasks or /tasks.json
  def create
    auth_guard
    user_id = signed_in_user.id
    now = Time.now.to_i
    title = params[:title]
    summary = params[:summary]
    @task = Task.new(user_id:user_id,title:title,summary:summary,date_added:now)
    respond_to do |format|
      if @task.save
        format.html { redirect_to controller:"users", action:"index" }
      else
        format.html { render :new }
      end
    end
  end

  # PATCH/PUT /tasks/1 or /tasks/1.json
  def update
    respond_to do |format|
      if @task.update(task_params)
        format.html { redirect_to @task, notice: "Task was successfully updated." }
        format.json { render :show, status: :ok, location: @task }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  def complete
   auth_guard
    respond_to {
      |format|
      task_id = params[:task_id]
      @task = Task.find_by(id:task_id,user_id:signed_in_user.id)
      if @task && @task.update(accomplished:1)
        format.html { redirect_to "/"}
      else
        @forbidden = true
        format.html { render layout:false }
      end
    }
  end
  # DELETE /tasks/1 or /tasks/1.json
  def destroy
    auth_guard
    @task.destroy
    respond_to do |format|
      format.html { redirect_to controller: "users", action: "index" }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_task
      @task = Task.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def task_params
      params.fetch(:task, {})
    end
end
