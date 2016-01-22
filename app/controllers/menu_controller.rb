class MenuController < ApplicationController
  def show
    # TODO:なんか力技なので、そのうち直す(effective_date の方をdatetimeにするのがいいのかな……)
    @infomsgs = Infomsg.where('effective_date <= ?', currentDate).order('effective_date DESC').limit(3)
  end
end
