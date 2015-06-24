class OrdersController < ApplicationController
  skip_before_filter :authorize, :only => [:create, :new ,:checkout]
  # GET /orders
  # GET /orders.xml
  # for express checkout by paypal
  include ActiveMerchant::Billing 
  def checkout 
    cart = Cart.find(current_cart.id)
    price_in_cents = cart.total_price
    response = EXPRESS_GATEWAY.setup_purchase(price_in_cents,
    :ip                => request.remote_ip,
    :return_url        => new_order_url,
    :cancel_return_url => products_url
    )
    redirect_to EXPRESS_GATEWAY.redirect_url_for(response.token)
  end

  def index
    @orders = Order.paginate :page=>params[:page], 
    :order=>'created_at desc', :per_page => 10
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @orders }
    end
  end

  # GET /orders/1
  # GET /orders/1.xml
  def show
    @order = Order.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @order }
    end
  end

  # GET /orders/new
  # GET /orders/new.xml
  def new
      @cart = current_cart
    if @cart.line_items.empty?
      redirect_to store_url, :notice => "Your cart is empty"
      return
    end
    @order = Order.new(:express_token => params[:token])
    cart = Cart.find(current_cart.id)
    respond_to do |format|
    format.html # new.html.erb
    format.xml { render :xml => @order}
    end
  end

  # GET /orders/1/edit
  def edit
    @order = Order.find(params[:id])
  end

  # POST /orders
  # POST /orders.xml
  def create
    @order = Order.new(params[:order])
    cart = Cart.find(current_cart.id)
    #@order.add_line_items_from_cart(current_cart)
    @order.ip_address = request.remote_ip
    respond_to do |format|
    if @order.save
       total_price = cart.total_price*100
      if @order.purchase(total_price) 
        @order.add_line_items_from_cart(current_cart)
        Cart.destroy(session[:cart_id])
        session[:cart_id] = nil
        Notifier.order_received(@order).deliver
        format.html { redirect_to(store_url,:notice=> I18n.t('.thanks')) }
        format.xml { render :xml => @order, :status => :created, :location => @order }
      end              
    else
        format.html { render :action => "new" }
        format.xml  { render :xml => @order.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /orders/1
  # PUT /orders/1.xml
  def update
    @order = Order.find(params[:id])

    respond_to do |format|
      if @order.update_attributes(params[:order])
        format.html { redirect_to(@order, :notice => 'Order was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @order.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /orders/1
  # DELETE /orders/1.xml
  def destroy
    @order = Order.find(params[:id])
    @order.destroy

    respond_to do |format|
      format.html { redirect_to(orders_url) }
      format.xml  { head :ok }
    end
  end
end
