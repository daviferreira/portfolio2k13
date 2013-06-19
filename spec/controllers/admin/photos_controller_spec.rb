require 'spec_helper'

describe Admin::PhotosController do

  let(:user) { FactoryGirl.create(:user) }
  let(:category) { FactoryGirl.create(:category) }
  let(:project) { FactoryGirl.create(:project, :name => "Sample Project", :category => category) }
  let(:photo) { FactoryGirl.create(:photo, :project => project)}

  context "when logged out" do
    it "should deny access to 'index'" do
      get :index
      response.should redirect_to new_user_session_path
    end

    it "should deny access to 'new'" do
      get :new
      response.should redirect_to new_user_session_path
    end

    it "should deny access to 'create'" do
      post :create
      response.should redirect_to new_user_session_path
    end

    it "should deny access to 'edit'" do
      get :edit, :id => photo
      response.should redirect_to new_user_session_path
    end

    it "should deny access to 'update'" do
      post :update, :id => photo, :photo => photo
      response.should redirect_to new_user_session_path
    end

    it "should deny access to 'destroy'" do
      delete :destroy, :id => 1
      response.should redirect_to new_user_session_path
    end
  end

  context "when logged in" do

    before { sign_in user }

    describe "GET 'index'" do

      it "returns http success" do
        get :index
        response.should be_success
      end

      it "should list all the photos" do
        p1 = FactoryGirl.create(:photo, :title => "Foo bar")
        p2 = FactoryGirl.create(:photo, :title => "Baz quux")
        get :index
        assigns(:photos).should eq([p1, p2])
      end

      it "should list ordering by project name and photo order" do
        project1 = FactoryGirl.create(:project, :name => "D Project")
        project2 = FactoryGirl.create(:project, :name => "B Project")
        project3 = FactoryGirl.create(:project, :name => "C Project")

        p1 = FactoryGirl.create(:photo, :title => "Photo 1", :project => project1, :order => 2)
        p2 = FactoryGirl.create(:photo, :title => "Photo 2", :project => project1, :order => 1)
        p3 = FactoryGirl.create(:photo, :title => "Photo 3", :project => project1, :order => 3)

        p4 = FactoryGirl.create(:photo, :title => "Photo 4", :project => project2, :order => 1)
        p5 = FactoryGirl.create(:photo, :title => "Photo 5", :project => project2, :order => 2)

        p6 = FactoryGirl.create(:photo, :title => "Photo 6", :project => project3, :order => 3)
        p7 = FactoryGirl.create(:photo, :title => "Photo 7", :project => project3, :order => 4)

        get :index

        assigns(:photos).should eq([p4, p5, p6, p7, p2, p1, p3])
      end

      it "should paginate the photos" do
        pending "implement will paginate"
      end

    end

    describe "create photo" do

      describe "GET 'new'" do
        it "returns http success" do
          get :new
          response.should be_success
        end
      end

      describe "POST 'create'" do
        it "should changes photo count by 1" do
          expect {
            post :create, :photo => {:title => "Test photo",
                                        :order => 2,
                                        :project_id => project.id,
                                        :file => fixture_file_upload('/images/rails.png', 'image/png')}
          }.to change(Photo, :count).by(1)
        end
      end

      describe "with invalid photo data" do
        it "should render new photo template" do
          post :create, :photo => Photo.new(title: "")
          response.should render_template("admin/photos/new")
        end
      end

      describe "with valid photo data" do
        it "should redirect to photos list" do
          post :create, :photo => {:title => "Test photo",
                                      :order => 2,
                                      :project_id => project.id,
                                      :file => fixture_file_upload('/images/rails.png', 'image/png')}
          response.should redirect_to admin_photos_path
        end
      end

    end

    describe "edit photo" do

      describe "GET 'edit'" do
        it "should return 404 when id is invalid" do
          get :edit, :id => "invalid"
          response.response_code.should == 404
        end

        it "returns http success" do
          get :edit, :id => photo
          response.should be_success
        end
      end

      describe "PUT 'update'" do

        describe "with invalid photo data" do
          it "should return 404 when id is invalid" do
            post :update, :id => "invalid"
            response.response_code.should == 404
          end

          it "should render edit photo template" do
            post :update, :id => photo, :photo => {:title => ""}
            response.should render_template("admin/photos/edit")
          end
        end

        describe "with valid photo data" do
          it "redirects to photo path" do
            put :update, :id => photo, :photo => {:title => "Editing photo"}
            response.should redirect_to edit_admin_photo_path(photo)
          end

          it "changes the photo title" do
            put :update, :id => photo, :photo => {:title => "Editing photo"}
            photo.reload
            photo.title.should == "Editing photo"
          end

        end

      end

    end

    describe "destroy photo" do

      describe "DELETE 'destroy'" do

        it "should return 404 when id is invalid" do
          delete :destroy, :id => "invalid"
          response.response_code.should == 404
        end

        it "should redirect to the photo listing path" do
          delete :destroy, :id => photo
          response.should redirect_to admin_photos_path
        end

        it "should delete a photo" do
          p1 = FactoryGirl.create(:photo)
          expect { delete :destroy, :id => p1 }.to change(Photo, :count).by(-1)
        end

      end

    end

  end

end
