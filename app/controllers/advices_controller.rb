class AdvicesController < ApplicationController
  # Edit, Update, Destroy에 대한 보안이슈를 해결해주세요. (자기 자신만 수정, 삭제 가능하게)
  before_action :set_advice, only: [:show, :edit, :update, :destroy]

  # GET /advices
  # GET /advices.json
  def index
    # params[:page]의 Default 값을 설정해 주면 좋을 것 같아요. > 빈값으로 오는경우 에러 발생
    
    @page = Advice.page(params[:page]).per(10)
    @advices = Advice.all.order(created_at: :desc).page(@page.current_page).per(@page.limit_value)
    # 어떤 연유인지 모르겠지만, 위와 같이 호출하면 @page와 @advice의 내용이 같을것 같은데 위와 같이 호출하면 2번 쿼리를 타게 됩니다.
    # @advices = Advice.all.order(created_at: :desc).page(@page.current_page).per(@page.limit_value)
    # @page = @advices  # for draw custom paginate
  end

  # GET /advices/1
  # GET /advices/1.json
  def show
  end

  # GET /advices/new
  def new
    @advice = Advice.new
  end

  # GET /advices/1/edit
  def edit
  end

  # POST /advices
  # POST /advices.json
  def create
    # Strong Parameter 를 사용해보세요.
    # https://edgeguides.rubyonrails.org/action_controller_overview.html#strong-parameters
    
    @advice = Advice.new(title: params[:advice][:title], cover: params[:advice][:cover])
    @advice.user = current_user
    advice_contents_params = params[:advice][:advice_contents];
    
    # 이부분을 하는 이유가 궁금합니다. 
    advice_contents_params.each do |advice_content_params|
      new_advice_content = nil
      content_type = advice_content_params[1][:content_type];
      if content_type == "photo"
        new_advice_content = AdviceContent.new(position: advice_content_params[1][:position], content_type: advice_content_params[1][:content_type], img: advice_content_params[1][:img], link: advice_content_params[1][:link], content: advice_content_params[1][:content]);
      elsif content_type == "card"
        new_advice_content = AdviceContent.new(position: advice_content_params[1][:position], content_type: advice_content_params[1][:content_type], content_id: advice_content_params[1][:content_id], img_url0: advice_content_params[1][:img_url], link: advice_content_params[1][:link], content: advice_content_params[1][:content]);
      elsif content_type == "text"
        new_advice_content = AdviceContent.new(position: advice_content_params[1][:position], content_type: advice_content_params[1][:content_type], content: advice_content_params[1][:content]);
      elsif content_type == "button"
        new_advice_content = AdviceContent.new(position: advice_content_params[1][:position], content_type: advice_content_params[1][:content_type], content: advice_content_params[1][:content], link: advice_content_params[1][:link]);
      end
      unless content_type.to_s.empty?
        @advice.advice_contents.push new_advice_content
      end
      # end
    end

    respond_to do |format|
      if @advice.save
        # 이부분은 제가 이해가 잘안되서 그러는데 설명듣고 주석을 해드릴게요!
        @advice.cover_url0 = @advice.cover.url
        @advice.advice_contents.each do |advice_content|
          if advice_content.content_type == "photo"
            advice_content.img_url0 = advice_content.img.url
          end
        end
        @advice.save
        format.html {redirect_to @advice, notice: 'Advice was successfully created.'}
        format.json {render :show, status: :created, location: @advice}
      else
        format.html {render :new}
        format.json {render json: @advice.errors, status: :unprocessable_entity}
      end
    end
  end

  # PATCH/PUT /advices/1
  # PATCH/PUT /advices/1.json
  def update
    # Create와 같은 맥락으로 Strong Parameter를 이용해보세요.
    
    @advice.title = params[:advice][:title];
    advice_contents_params = params[:advice][:advice_contents];
    advice_contents_params.each do |advice_content_params|
      if advice_content_params[1][:id] && advice_content_params[1][:id] != "0"
        advice_content = @advice.advice_contents.find_by(id: advice_content_params[1][:id])
        if advice_content_params[1][:_destroy] == 'true'
          advice_content.delete
        else
          advice_content.position = advice_content_params[1][:position]
          content_type = advice_content.content_type
          if content_type == "photo" || content_type == "card"
            advice_content.link = advice_content_params[1][:link]
            advice_content.content = advice_content_params[1][:content]
          elsif content_type == "text"
            advice_content.content = advice_content_params[1][:content]
          elsif content_type == "button"
            advice_content.link = advice_content_params[1][:link]
            advice_content.content = advice_content_params[1][:content]
          end
          advice_content.save
        end
      else
        new_advice_content = nil
        content_type = advice_content_params[1][:content_type]
        if content_type == "photo"
          new_advice_content = AdviceContent.new(position: advice_content_params[1][:position], content_type: advice_content_params[1][:content_type], img: advice_content_params[1][:img], link: advice_content_params[1][:link], content: advice_content_params[1][:content]);
        elsif content_type == "card"
          new_advice_content = AdviceContent.new(position: advice_content_params[1][:position], content_type: advice_content_params[1][:content_type], content_id: advice_content_params[1][:content_id], img_url0: advice_content_params[1][:img_url], link: advice_content_params[1][:link], content: advice_content_params[1][:content]);
        elsif content_type == "text"
          new_advice_content = AdviceContent.new(position: advice_content_params[1][:position], content_type: advice_content_params[1][:content_type], content: advice_content_params[1][:content]);
        elsif content_type == "button"
          new_advice_content = AdviceContent.new(position: advice_content_params[1][:position], content_type: advice_content_params[1][:content_type], content: advice_content_params[1][:content], link: advice_content_params[1][:link]);
        end
        unless content_type.to_s.empty?
          @advice.advice_contents.push new_advice_content
        end
      end
    end

    respond_to do |format|
      if @advice.save
        @advice.cover_url0 = @advice.cover.url
        @advice.advice_contents.each do |advice_content|
          if advice_content.content_type == "photo"
            advice_content.img_url0 = advice_content.img.url
          end
        end
        @advice.save
        format.html {redirect_to @advice, notice: 'Advice was successfully updated.'}
        format.json {render :show, status: :ok, location: @advice}
      else
        format.html {render :edit}
        format.json {render json: @advice.errors, status: :unprocessable_entity}
      end
    end
  end

  # DELETE /advices/1
  # DELETE /advices/1.json
  def destroy
    @advice.destroy
    respond_to do |format|
      format.html {redirect_to advices_url, notice: 'Advice was successfully destroyed.'}
      format.json {head :no_content}
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_advice
    # Advice가 없을때 예외 처리가 필요
    @advice = Advice.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def advice_params
    # strong parameter 필요
    params.fetch(:advice, {})
  end
end
