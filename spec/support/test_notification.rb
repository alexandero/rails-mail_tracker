class TestNotification < ActionMailer::Base
  default :from => "from@example.com",
          :to => "to@example.org"

  def hello
    mail :subject => "Hello!" do |format|
      format.html { render :text => '<!DOCTYPE html><html><body>HTML mail with links to <a href="http://one.to">one</a> and to <a href="http://two.to">two</a>. Some text.</body></html>' }
      format.text { render :text => 'Text mail' }
    end
  end
end
