class MenuController < ApplicationController
  def show
    # TODO: なんか力技なので、そのうち直す(effective_date の方をdatetimeにするのがいいのかな……)
    @infomsgs = Infomsg.where('effective_date <= ?', current_date).order(effective_date: :desc).limit(3)
  end
end
