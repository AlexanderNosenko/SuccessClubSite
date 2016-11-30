require "rails_helper"

RSpec.describe Notifications, type: :mailer do
  describe "role_reset" do
    let(:user) { User.first }
    let(:mail) { Notifications.role_reset(User.first) }

    it "renders the headers" do
      expect(mail.subject).to eq("Статус Партнер")
      expect(mail.to).to eq([user.email])
      expect(mail.from).to eq(["notify@improf.club"])
    end

    it "renders the body" do
      expect(mail.text_part.body).to match("пополните Ваш баланс")
    end
  end

end
