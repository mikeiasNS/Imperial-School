require 'rails_helper'

RSpec.describe TeachersController, type: :controller do
  let(:user){User.create!(name: 'test', username: 'test', password: '123')}
  let(:school){School.create!(name: 'test school')}
  let(:unit){Unit.create!(name: 'test unit', school_id: school.id)}
  let(:teacher){Teacher.create!(name: 'test teacher', cpf: '123', birthday: '01/01/1999', unit_id: unit.id)}

  describe "GET index" do
    context 'when logged in' do
      before do
        request.session[:user_id] = user.id
        get :index
      end

      it{expect(response.status).to eq(200)}
    end

    context 'when logged out' do
      before do
        get :index
      end

      it{expect(response.status).to eq(302)}
      it{expect(response).to redirect_to(login_path)}
    end
  end

  describe "GET new" do
    context 'when logged in' do
      before do
        request.session[:user_id] = user.id
        get :new
      end

      it{expect(response.status).to eq(200)}
    end

    context 'when logged out' do
      before do
        get :new
      end

      it{expect(response.status).to eq(302)}
      it{expect(response).to redirect_to(login_path)}
    end
  end

  describe "GET edit" do
    context 'when logged in' do
      before do
        request.session[:user_id] = user.id
        get :edit, params: {id: teacher.id}
      end

      it{expect(response.status).to eq(200)}
    end

    context 'when logged out' do
      before do
        get :edit, params: {id: teacher.id}
      end

      it{expect(response.status).to eq(302)}
      it{expect(response).to redirect_to(login_path)}
    end
  end

  describe "POST create" do
    context 'when logged in' do
      before do
        request.session[:user_id] = user.id
        post :create, params: {teacher: teacher.attributes}
      end

      it{expect(response.status).to eq(302)}
      it{expect(response.status).to redirect_to(teachers_path)}
    end

    context 'when logged out' do
      before do
        post :create, params: {teacher: teacher.attributes}
      end

      it{expect(response.status).to eq(302)}
      it{expect(response).to redirect_to(login_path)}
    end

    context 'when receive invalid params' do
      before do
        request.session[:user_id] = user.id
        post :create, params: {teacher: {invalid: 'test'}}
      end

      it{expect(response.status).to eq(422)}
    end
  end

  describe "PUT update" do
    context 'when logged in' do
      before do
        request.session[:user_id] = user.id
        put :update, params: {id: teacher.id, teacher: teacher.attributes}
      end

      it{expect(response.status).to eq(302)}
      it{expect(response.status).to redirect_to(teachers_path)}
    end

    context 'when logged out' do
      before do
        put :update, params: {id: teacher.id, teacher: teacher.attributes}
      end

      it{expect(response.status).to eq(302)}
      it{expect(response).to redirect_to(login_path)}
    end

    context 'when receive invalid params' do
      before do
        request.session[:user_id] = user.id
        put :update, params: {id: teacher.id, teacher: {invalid: 'test'}}
      end

      it{expect(response.status).to eq(302)}
      it{expect(response.status).to redirect_to(teachers_path)}
    end
  end

  describe "DELETE destroy" do
    context 'when logged in' do
      before do
        request.session[:user_id] = user.id
        delete :destroy, params: {id: teacher.id}
      end

      it{expect(response.status).to eq(302)}
      it{expect(response.status).to redirect_to(teachers_path)}
    end

    context 'when logged out' do
      before do
        delete :destroy, params: {id: teacher.id}
      end

      it{expect(response.status).to eq(302)}
      it{expect(response).to redirect_to(login_path)}
    end
  end
end
