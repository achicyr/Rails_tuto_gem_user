class PostsController < ApplicationController
  # before_action :set_post, only: %i[ show edit update destroy ]
  # authorize_resource # method fourni par cancancan

  # before_action, only: %i[ show edit update destroy ]
  load_and_authorize_resource # method fourni par cancancan, et fait pareil que la fonction du scaffold "set_post"



  def me # ACCÉDER À MES ACTICLES
    # AVEC can :manage, Post (dans le model Ability), toutes les actions peuvent accéder aux données de Post (contrairement à "can :read" et etc)
    @posts = current_user.posts
    render :index
  end
  
  # GET /posts or /posts.json
  def index
    puts
    puts
    puts can? :read, Post # :show et :index
    puts can? :manage, Post # 
    puts can? :all, Post # 
    puts cannot? :all, Post # 
    
    # authorize! :read, Post# Authorise seulement les users ayants étés authorisés à :read (défini dans model Ability)
    @posts = Post.all
  end

  # GET /posts/1 or /posts/1.json
  def show
  end

  # GET /posts/new
  def new
    @post = Post.new
  end

  # GET /posts/1/edit
  def edit
  end

  # POST /posts or /posts.json
  def create
    # @post = Post.new(post_params)
    @post = current_user.posts.new(post_params) # AFIN D'ASSOCIER DIRECTEMENT LE POST CRÉÉ AU current_user

    respond_to do |format|
      if @post.save
        format.html { redirect_to post_url(@post), notice: "Post was successfully created." }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1 or /posts/1.json
  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to post_url(@post), notice: "Post was successfully updated." }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1 or /posts/1.json
  def destroy
    @post.destroy

    respond_to do |format|
      format.html { redirect_to posts_url, notice: "Post was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    # def set_post
    #   @post = Post.find(params[:id])
    # end

    # Only allow a list of trusted parameters through.
    def post_params
      # params.require(:post).permit(:name, :content, :user_id, :image)
      params.require(:post).permit(:name, :content, :image) # ON EMPECHE DE POUVOIR MODIFIER À QUEL user APPARTIENT CE @post
    end
end
