class Api::V1::ReservationsController < ApiController
  before_action :authenticate_user!, :only => [:index]  # 这会检查 index +这个操作一定要登入

  def index       #查当前用户地所有订票
    @reservations = current_user.reservations

    render :json => {
      :date => @reservations.map { |reservation|
        {
          :booking_code => reservation.booking_code,
          :train_number => reservation.train.number,
          :seat_number => reservation.seat_number,
          :customer_name => reservation.customer_name,
          :customer_phone => reservation.customer_phone
        }
      }
    }
  end

  def create
    @train = Train.find_by_number!( params[:train_number] )
    @reservation = Reservation.new( :train_id => @train.id,
                                    :seat_number => params[:seat_number],
                                    :customer_name => params[:customer_name],
                                    :customer_phone => params[:customer_phone] )

    @reservation.user = current_user      #这张定票关联到登录的用户

    if @reservation.save
      render :json => { :booking_code => @reservation.booking_code,
                        :reservation_url => api_v1_reservation_url(@reservation.booking_code) }
    else
      render :json => { :message => "订票失败", :errors => @reservation.errors }, :status => 400
    end
  end

  def show
    @reservation = Reservation.find_by_booking_code!( params[:booking_code] )

    render :json => {
      :booking_code => @reservation.booking_code,
      :train_number => @reservation.train.number,
      :seat_number => @reservation.seat_number,
      :customer_name => @reservation.customer_name,
      :customer_phone => @reservation.customer_phone
    }
  end

  def update
    @reservation = Reservation.find_by_booking_code!( params[:booking_code] )
    @reservation.update( :customer_name => params[:customer_name],
                          :customer_phone => params[:customer_phone] )

    render :json => { :message => "更新成功" }
  end

  def destroy
    @reservation = Reservation.find_by_booking_code!( params[:booking_code] )
    @reservation.destroy

    render :json => { :message => "已取消订位" }
  end

end
