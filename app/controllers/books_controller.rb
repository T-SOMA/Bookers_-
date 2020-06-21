class BooksController < ApplicationController
	before_action :authenticate_user!
	before_action :correct_user, only: [:edit, :update]
	def index
		@books = Book.all
		@book = Book.new
	end
	def create
		@book = Book.new(book_params)
		@book.user_id = current_user.id
  		if @book.save
  			flash[:notice] = "You have creatad book successfully."
  			redirect_to book_path(@book.id)
  		else
  			@books = Book.all
  			render 'index'
  		end
	end
	def show
		@book = Book.find(params[:id])
		@books = Book.all
	end

	def edit
		@book = Book.find(params[:id])
	end
	def update
		book = Book.find(params[:id])
		if book.update(book_params)
			flash[:notice] = "You have updated book successfully."
			redirect_to book_path(book.id)
		else
			@book = book
			render 'edit'
		end
	end

	def destroy
		book = Book.find(params[:id])
		book.destroy
	  	# flash[:notice] = "Book was successfully destroyed."
	  	redirect_to books_path
	end

	def correct_user
    	@user = User.find(params[:id])
    	if @user == current_user
    		redirect_to books_path
    	end
  	end

	private
	def book_params
  		params.require(:book).permit(:title, :body)
  	end
end
