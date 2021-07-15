import 'dart:convert';

import 'package:flutter_unicef_2/pojo/awareness_model.dart';
import 'package:flutter_unicef_2/pojo/course.activity/my_course_activity.dart';
import 'package:flutter_unicef_2/pojo/course/course_details_response.dart';
import 'package:flutter_unicef_2/pojo/course/course_outline_response.dart';
import 'package:flutter_unicef_2/pojo/course/course_progress_response.dart';
import 'package:flutter_unicef_2/pojo/course/course_response.dart';
import 'package:flutter_unicef_2/pojo/course/course_submission.dart';
import 'package:flutter_unicef_2/pojo/course/my_course_score_details_response.dart';
import 'package:flutter_unicef_2/pojo/exploreservice/map_cart_info_model.dart';
import 'package:flutter_unicef_2/pojo/exploreservice/map_district_model.dart';
import 'package:flutter_unicef_2/pojo/exploreservice/map_division_model.dart';
import 'package:flutter_unicef_2/pojo/exploreservice/organization_list_model.dart';
import 'package:flutter_unicef_2/pojo/hotline/hotline_response.dart';
import 'package:flutter_unicef_2/pojo/knowledgebooth/applink_response.dart';
import 'package:flutter_unicef_2/pojo/knowledgebooth/faq_response.dart';
import 'package:flutter_unicef_2/pojo/knowledgebooth/ic_resource.dart';
import 'package:flutter_unicef_2/pojo/knowledgebooth/knowledge_response.dart';
import 'package:flutter_unicef_2/pojo/knowledgebooth/resource_menu.dart';
import 'package:flutter_unicef_2/pojo/location/district_response.dart';
import 'package:flutter_unicef_2/pojo/location/division_response.dart';
import 'package:flutter_unicef_2/pojo/login/ForgetPassordResponseModel.dart';
import 'package:flutter_unicef_2/pojo/login/basic_info.dart';
import 'package:flutter_unicef_2/pojo/login/basic_information_response.dart';
import 'package:flutter_unicef_2/pojo/login/login_response.dart';
import 'package:flutter_unicef_2/pojo/login/passwordUpdateResponse.dart';
import 'package:flutter_unicef_2/pojo/policy_guideline/video_content_model.dart';
import 'package:flutter_unicef_2/pojo/policy_guideline_model.dart';
import 'package:flutter_unicef_2/pojo/quiz/quiz_post.dart';
import 'package:flutter_unicef_2/pojo/quiz/quiz_response.dart';
import 'package:flutter_unicef_2/pojo/result/my_course_result_response.dart';
import 'package:flutter_unicef_2/pojo/survey_conference_model.dart';
import 'package:flutter_unicef_2/utils/Constant.dart';
import 'package:http/http.dart' as http;
import 'package:sp_util/sp_util.dart';

import 'ApiResponse.dart';

class ApiInterface {
  Future<ApiResponse<CourseCategoryResponse>?> getCategoryCourse() {
    return http.get(Uri.parse(BASE_URL + "get-course-all"),
        headers: {'Content-Type': 'application/json'}).then((value) {
      if (value.statusCode == 200) {
        var jsonData = json.decode(value.body);
        CourseCategoryResponse courseCategoryResponse =
            CourseCategoryResponse.fromJson(jsonData);
        return ApiResponse<CourseCategoryResponse>(
            data: courseCategoryResponse, error: false);
      }
    }).catchError((error) {
      return ApiResponse<bool>(error: true, errorMessage: error);
    });
  }

  Future<ApiResponse<MapCartInfoModel>?> getMapCartInfo() {
    return http.get(Uri.parse(BASE_URL + "map-cart-info"),
        headers: {'Content-Type': 'application/json'}).then((value) {
      if (value.statusCode == 200) {
        var jsonData = json.decode(value.body);
        MapCartInfoModel mapCartInfoModel = MapCartInfoModel.fromJson(jsonData);
        return ApiResponse<MapCartInfoModel>(
            data: mapCartInfoModel, error: false);
      }
    }).catchError((error) {
      return ApiResponse<bool>(error: true, errorMessage: error);
    });
  }

  Future<ApiResponse<GetOrganizationListModel>?> getAllOrganizationList(
      {disId, divId, facTyp}) {
    return http.get(
        Uri.parse(BASE_URL +
            "get-organization-info?division_id=$divId&district_id=$disId&facility_type=$facTyp"),
        headers: {'Content-Type': 'application/json'}).then((value) {
      if (value.statusCode == 200) {
        var jsonData = json.decode(value.body);
        GetOrganizationListModel getOrganizationListModel =
            GetOrganizationListModel.fromJson(jsonData);
        return ApiResponse<GetOrganizationListModel>(
            data: getOrganizationListModel, error: false);
      }
    }).catchError((error) {
      return ApiResponse<bool>(error: true, errorMessage: error);
    });
  }

  Future<ApiResponse<MyCourseResponse>?> getMyCourses() {
    return http.get(Uri.parse(BASE_URL + "get-my-activity"), headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': BEARER + SpUtil.getString(API_TOKEN, defValue: "")!
    }).then((value) {
      if (value.statusCode == 200) {
        MyCourseResponse myCourseResponse =
            MyCourseResponse.fromJson(json.decode(value.body));
        return ApiResponse<MyCourseResponse>(
            data: myCourseResponse, error: false);
      } else {
        return ApiResponse<MyCourseResponse>(
            error: true, errorMessage: "Server error");
      }
    }).catchError((error) {
      return ApiResponse<MyCourseResponse>(error: true, errorMessage: error);
    });
  }

  Future<ApiResponse<MyCourseResultDetailsResponse>> getMyCourseResultDetails(
      String id) {
    return http.get(
        Uri.parse(BASE_URL + "get-my-score-board-details?course_id=$id"),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': BEARER + SpUtil.getString(API_TOKEN, defValue: "")!
        }).then((value) {
      if (value.statusCode == 200) {
        MyCourseResultDetailsResponse myCourseResultDetailsResponse =
            MyCourseResultDetailsResponse.fromJson(json.decode(value.body));
        return ApiResponse<MyCourseResultDetailsResponse>(
            data: myCourseResultDetailsResponse, error: false);
      } else {
        return ApiResponse<MyCourseResultDetailsResponse>(
            error: true, errorMessage: "Server error");
      }
    }).catchError((error) {
      return ApiResponse<MyCourseResultDetailsResponse>(
          error: true, errorMessage: error);
    });
  }

  Future<ApiResponse<QuizDetailsResponse>> getQuizDetails(var id) {
    return http.get(
        Uri.parse(BASE_URL + "get-quiz-questions?question_set_id=$id"),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': BEARER + SpUtil.getString(API_TOKEN, defValue: "")!
        }).then((value) {
      if (value.statusCode == 200) {
        QuizDetailsResponse quizDetailsResponse =
            QuizDetailsResponse.fromJson(json.decode(value.body));
        return ApiResponse<QuizDetailsResponse>(
            data: quizDetailsResponse, error: false);
      } else {
        return ApiResponse<QuizDetailsResponse>(
            error: true, errorMessage: "Server error");
      }
    }).catchError((error) {
      return ApiResponse<QuizDetailsResponse>(error: true, errorMessage: error);
    });
  }

  Future<ApiResponse<QuizResultPost>> postQuizResult(
      QuizResultPost quizResultPost) {
    return http.post(Uri.parse(BASE_URL + "post-quiz-result"),
        body: json.encode(quizResultPost.toQuiz()),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': BEARER + SpUtil.getString(API_TOKEN, defValue: "")!
        }).then((value) {
      if (value.statusCode == 200) {
        QuizResultPost quizResultPost =
            QuizResultPost.fromJson(json.decode(value.body));
        return ApiResponse<QuizResultPost>(data: quizResultPost, error: false);
      } else {
        return ApiResponse<QuizResultPost>(
            error: true, errorMessage: "Server error");
      }
    }).catchError((error) {
      return ApiResponse<QuizResultPost>(error: true, errorMessage: error);
    });
  }

  Future<ApiResponse<CourseProgressResponse>> postCourseProgress(
      CourseProgressResponse courseProgressResponse) {

    return http.post(Uri.parse(BASE_URL + "post-assign-course-progress"),
        body: json.encode(courseProgressResponse.toCourseProgressJson()),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': BEARER + SpUtil.getString(API_TOKEN, defValue: "")!
        }).then((value) {
      if (value.statusCode == 200) {
        CourseProgressResponse courseProgressResponse =
            CourseProgressResponse.fromJson(json.decode(value.body));
        return ApiResponse<CourseProgressResponse>(
            data: courseProgressResponse, error: false);
      } else {
        return ApiResponse<CourseProgressResponse>(
            error: true, errorMessage: "Server error");
      }
    }).catchError((error) {
      return ApiResponse<CourseProgressResponse>(
          error: true, errorMessage: error);
    });
  }

  Future<ApiResponse<CourseSubmissionResponse>> postCourseSubmission(
      CourseSubmissionResponse courseSubmissionResponse) {
    return http.post(Uri.parse(BASE_URL + "post-course-subscription"),
        body: json.encode(courseSubmissionResponse.toCourseJson()),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': BEARER + SpUtil.getString(API_TOKEN, defValue: "")!
        }).then((value) {
      if (value.statusCode == 200) {
        CourseSubmissionResponse courseSubmissionResponse =
            CourseSubmissionResponse.fromJson(json.decode(value.body));
        return ApiResponse<CourseSubmissionResponse>(
            data: courseSubmissionResponse, error: false);
      } else {
        return ApiResponse<CourseSubmissionResponse>(
            error: true, errorMessage: "Server error");
      }
    }).catchError((error) {
      return ApiResponse<CourseSubmissionResponse>(
          error: true, errorMessage: error);
    });
  }

  Future<ApiResponse<LoginResponse>> postLogin(LoginData loginData) {
    return http.post(Uri.parse(BASE_URL + "login?"),
        body: json.encode(loginData.toLogin()),
        headers: {'Content-Type': 'application/json'}).then((value) {
      var jsonData = json.decode(value.body);
      LoginResponse loginResponse = LoginResponse.fromJson(jsonData);
      return ApiResponse<LoginResponse>(data: loginResponse, error: false);
    }).catchError((error) {
      return ApiResponse<bool>(error: true, errorMessage: error);
    });
  }

  Future<ApiResponse<ForgetPasswordResponseModel>> sendPasswordResetOtp(
      forgetPasswordModel) {
    return http.post(Uri.parse(BASE_URL + "forgot-password?"),
        body: json.encode(forgetPasswordModel.toJson()),
        headers: {'Content-Type': 'application/json'}).then((value) {
      var jsonData = json.decode(value.body);

      ForgetPasswordResponseModel responseModel =
          ForgetPasswordResponseModel.fromJson(jsonData);
      return ApiResponse<ForgetPasswordResponseModel>(
          data: responseModel, error: false);
    }).catchError((error) {
      return ApiResponse<bool>(error: true, errorMessage: error);
    });
  }

  Future<ApiResponse<PasswordUpdateResponseModel>> passwordUpdate(updateModel) {
    return http.post(Uri.parse(BASE_URL + "forgot-password-update?"),
        body: json.encode(updateModel.toJson()),
        headers: {'Content-Type': 'application/json'}).then((value) {
      var jsonData = json.decode(value.body);
      PasswordUpdateResponseModel loginResponse =
          PasswordUpdateResponseModel.fromJson(jsonData);
      return ApiResponse<PasswordUpdateResponseModel>(
        data: loginResponse,
        error: false,
      );
    }).catchError((error) {
      return ApiResponse<bool>(error: true, errorMessage: error);
    });
  }

  Future<ApiResponse<LoginResponse>> postRegistration(LoginData loginData) {
    return http.post(Uri.parse(BASE_URL + "register"),
        body: json.encode(loginData.toRegistration()),
        headers: {'Content-Type': 'application/json'}).then((value) {
      var jsonData = json.decode(value.body);
      LoginResponse loginResponse = LoginResponse.fromJson(jsonData);
      return ApiResponse<LoginResponse>(data: loginResponse, error: false);
    }).catchError((error) {
      return ApiResponse<bool>(error: true, errorMessage: error);
    });
  }

  Future<ApiResponse<CourseOutlineResponse>?> getCourseOutline(String id) {
    return http.get(Uri.parse(BASE_URL + "get-course-outline?course_id=$id"),
        headers: {'Content-Type': 'application/json'}).then((value) {
      if (value.statusCode == 200) {
        var jsonData = json.decode(value.body);
        CourseOutlineResponse courseOutlineResponse =
            CourseOutlineResponse.fromJson(jsonData);
        return ApiResponse<CourseOutlineResponse>(
            data: courseOutlineResponse, error: false);
      }
    }).catchError((error) {
      return ApiResponse<bool>(error: true, errorMessage: error);
    });
  }

  Future<ApiResponse<CourseOutlineResponse>?> getCourseOutlineWithAuth(
      String id) {
    return http.get(
        Uri.parse(BASE_URL + "get-course-outline-authorized?course_id=$id"),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': BEARER + SpUtil.getString(API_TOKEN, defValue: "")!
        }).then((value) {
      if (value.statusCode == 200) {
        var jsonData = json.decode(value.body);
        CourseOutlineResponse courseOutlineResponse =
            CourseOutlineResponse.fromJson(jsonData);
        return ApiResponse<CourseOutlineResponse>(
            data: courseOutlineResponse, error: false);
      }
    }).catchError((error) {
      return ApiResponse<bool>(error: true, errorMessage: error);
    });
  }

  Future<ApiResponse<MyCourseResultResponse>> getMyCourseResult() {
    return http.get(Uri.parse(BASE_URL + "get-my-score-board"), headers: {
      'Content-Type': 'application/json',
      'Authorization': BEARER + SpUtil.getString(API_TOKEN, defValue: "")!
    }).then((value) {
      if (value.statusCode == 200) {
        var jsonData = json.decode(value.body);
        MyCourseResultResponse myCourseResultResponse =
            MyCourseResultResponse.fromJson(jsonData);
        return ApiResponse<MyCourseResultResponse>(
            data: myCourseResultResponse, error: false);
      } else {
        return ApiResponse<MyCourseResultResponse>(error: true);
      }
    }).catchError((error) {
      return ApiResponse<bool>(error: true, errorMessage: error);
    });
  }

  Future<ApiResponse<HotlineResponse>?> getHotline() {
    var queryParameters = {
      'type': 'hotline',
    };
    String queryString = Uri(queryParameters: queryParameters).query;
    return http.get(Uri.parse(BASE_URL + "get-hotline" + "?" + queryString),
        headers: {'Content-Type': 'application/json'}).then((value) {
      if (value.statusCode == 200) {
        var jsonData = json.decode(value.body);
        HotlineResponse hotlineResponse = HotlineResponse.fromJson(jsonData);
        return ApiResponse<HotlineResponse>(
            data: hotlineResponse, error: false);
      }
    }).catchError((error) {
      return ApiResponse<bool>(error: true, errorMessage: error);
    });
  }

  Future<ApiResponse<MenuResponse>?> getMenu() {
    return http.get(Uri.parse(BASE_URL + "get-resource-menu"),
        headers: {'Content-Type': 'application/json'}).then((value) {
      if (value.statusCode == 200) {
        var jsonData = json.decode(value.body);
        MenuResponse menuResponse = MenuResponse.fromJson(jsonData);
        return ApiResponse<MenuResponse>(data: menuResponse, error: false);
      }
    }).catchError((error) {
      return ApiResponse<bool>(error: true, errorMessage: error);
    });
  }

  Future<ApiResponse<ResourceMaterial>?> getResourceMaterial() {
    return http.get(
        Uri.parse(BASE_URL + "get-resource-all?resourse_type=iec-mateirals"),
        headers: {'Content-Type': 'application/json'}).then((value) {
      if (value.statusCode == 200) {
        var jsonData = json.decode(value.body);
        ResourceMaterial resourceMaterial = ResourceMaterial.fromJson(jsonData);
        return ApiResponse<ResourceMaterial>(
            data: resourceMaterial, error: false);
      }
    }).catchError((error) {
      return ApiResponse<bool>(error: true, errorMessage: error);
    });
  }

  Future<ApiResponse<CourseDetailsResponse>?> getCourseDetails(String id) {
    return http.get(Uri.parse(BASE_URL + "get-course-content?content_id=$id"),
        headers: {'Content-Type': 'application/json'}).then((value) {
      if (value.statusCode == 200) {
        var jsonData = json.decode(value.body);
        CourseDetailsResponse courseDetailsResponse =
            CourseDetailsResponse.fromJson(jsonData);
        return ApiResponse<CourseDetailsResponse>(
            data: courseDetailsResponse, error: false);
      }
    }).catchError((error) {
      return ApiResponse<bool>(error: true, errorMessage: error);
    });
  }

  Future<ApiResponse<AwarenessMessageModel>?> getAwarenessMessage() {
    return http.get(Uri.parse(BASE_URL + "get-awareness-message"),
        headers: {'Content-Type': 'application/json'}).then((value) {
      if (value.statusCode == 200) {
        var jsonData = json.decode(value.body);
        AwarenessMessageModel awarenessMessageModel =
            AwarenessMessageModel.fromJson(jsonData);
        return ApiResponse<AwarenessMessageModel>(
            data: awarenessMessageModel, error: false);
      }
    }).catchError((error) {
      return ApiResponse<bool>(error: true, errorMessage: error);
    });
  }

  Future<ApiResponse<DivisionResponse>?> getDivision() {
    return http.get(Uri.parse(BASE_URL + "get-divisions"),
        headers: {'Content-Type': 'application/json'}).then((value) {
      if (value.statusCode == 200) {
        var jsonData = json.decode(value.body);
        DivisionResponse divisionResponse = DivisionResponse.fromJson(jsonData);
        return ApiResponse<DivisionResponse>(
            data: divisionResponse, error: false);
      }
    }).catchError((error) {
      return ApiResponse<bool>(error: true, errorMessage: error);
    });
  }

  Future<ApiResponse<MapDivisionModel>?> getMapDivision() {
    return http.get(Uri.parse(BASE_URL + "get-map-divisions"),
        headers: {'Content-Type': 'application/json'}).then((value) {
      if (value.statusCode == 200) {
        var jsonData = json.decode(value.body);
        MapDivisionModel mapDivisionModeld =
            MapDivisionModel.fromJson(jsonData);
        return ApiResponse<MapDivisionModel>(
            data: mapDivisionModeld, error: false);
      }
    }).catchError((error) {
      return ApiResponse<bool>(error: true, errorMessage: error);
    });
  }

  Future<ApiResponse<DistrictResponse>?> getDistrict(String id) {
    return http.get(Uri.parse(BASE_URL + "get-districts?division_id=$id"),
        headers: {'Content-Type': 'application/json'}).then((value) {
      if (value.statusCode == 200) {
        var jsonData = json.decode(value.body);
        DistrictResponse districtResponse = DistrictResponse.fromJson(jsonData);
        return ApiResponse<DistrictResponse>(
            data: districtResponse, error: false);
      }
    }).catchError((error) {
      return ApiResponse<bool>(error: true, errorMessage: error);
    });
  }

  Future<ApiResponse<MapDistrictModel>?> getMapDistrict(String id) {
    return http.get(Uri.parse(BASE_URL + "get-map-districts?division_id=$id"),
        headers: {'Content-Type': 'application/json'}).then((value) {
      if (value.statusCode == 200) {
        var jsonData = json.decode(value.body);
        MapDistrictModel districtResponse = MapDistrictModel.fromJson(jsonData);
        return ApiResponse<MapDistrictModel>(
            data: districtResponse, error: false);
      }
    }).catchError((error) {
      return ApiResponse<bool>(error: true, errorMessage: error);
    });
  }

  Future<ApiResponse<KnowledgeResponse>?> getKnowledgeBooth() {
    var queryParameters = {
      'type': 'knowledge_toolkit',
    };
    String queryString = Uri(queryParameters: queryParameters).query;

    return http.get(
        Uri.parse(BASE_URL + "get-knowledge-booth-data" + "?" + queryString),
        headers: {'Content-Type': 'application/json'}).then((value) {
      if (value.statusCode == 200) {
        var jsonData = json.decode(value.body);
        KnowledgeResponse knowledgeResponse =
            KnowledgeResponse.fromJson(jsonData);
        return ApiResponse<KnowledgeResponse>(
            data: knowledgeResponse, error: false);
      }
    }).catchError((error) {
      return ApiResponse<bool>(error: true, errorMessage: error);
    });
  }

  Future<ApiResponse<FaqResponse>?> getFaqList() {
    var queryParameters = {
      'type': 'faq',
    };
    String queryString = Uri(queryParameters: queryParameters).query;

    return http.get(Uri.parse(BASE_URL + "get-faq" + "?" + queryString),
        headers: {'Content-Type': 'application/json'}).then((value) {
      if (value.statusCode == 200) {
        var jsonData = json.decode(value.body);
        FaqResponse faqResponse = FaqResponse.fromJson(jsonData);
        return ApiResponse<FaqResponse>(data: faqResponse, error: false);
      }
    }).catchError((error) {
      return ApiResponse<bool>(error: true, errorMessage: error);
    });
  }

  Future<ApiResponse<AppLinkResponse>?> getAppLink() {
    return http.get(Uri.parse(BASE_URL + "get-app-link"),
        headers: {'Content-Type': 'application/json'}).then((value) {
      if (value.statusCode == 200) {
        var jsonData = json.decode(value.body);
        AppLinkResponse appLinkResponse = AppLinkResponse.fromJson(jsonData);
        return ApiResponse<AppLinkResponse>(
            data: appLinkResponse, error: false);
      }
    }).catchError((error) {
      return ApiResponse<bool>(error: true, errorMessage: error);
    });
  }

  Future<ApiResponse<BasicInfoResponse>?> postBasicInformation(
      BasicInfoResponse basicInfoResponse) {

    return http.post(Uri.parse(BASE_URL + "register-as-guest"),
        body: json.encode(basicInfoResponse.toBasicInformation()),
        headers: {'Content-Type': 'application/json'}).then((value) {
      if (value.statusCode == 200) {
        var jsonData = json.decode(value.body);
        BasicInfoResponse basicInfoResponse =
            BasicInfoResponse.fromJson(jsonData);
        return ApiResponse<BasicInfoResponse>(
            data: basicInfoResponse, error: false);
      } else if (value.statusCode == 400) {
        var jsonData = json.decode(value.body);
        BasicInfoResponse basicInfoResponse =
            BasicInfoResponse.fromJson(jsonData);
        return ApiResponse<BasicInfoResponse>(
            data: basicInfoResponse, error: false);
      }
    }).catchError((error) {
      return ApiResponse<bool>(error: true, errorMessage: error);
    });
  }

  Future<ApiResponse<BasicInformationResponse>?> getBasicInformationData(
      var deviceId) {
    return http.get(
        Uri.parse(BASE_URL + "get-guest-user-data?deviceID=$deviceId"),
        headers: {'Content-Type': 'application/json'}).then((value) {
      if (value.statusCode == 200) {
        var jsonData = json.decode(value.body);
        BasicInformationResponse basicInformationResponse =
            BasicInformationResponse.fromJson(jsonData);
        return ApiResponse<BasicInformationResponse>(
            data: basicInformationResponse, error: false);
      }
    }).catchError((error) {
      return ApiResponse<bool>(error: true, errorMessage: error);
    });
  }

  Future<ApiResponse<VideoContentModel>?> getVideoContent() {
    return http.get(Uri.parse(BASE_URL + "get-video-content"),
        headers: {'Content-Type': 'application/json'}).then((value) {
      if (value.statusCode == 200) {
        var jsonData = json.decode(value.body);
        VideoContentModel videoContentModel =
            VideoContentModel.fromJson(jsonData);
        return ApiResponse<VideoContentModel>(
            data: videoContentModel, error: false);
      }
    }).catchError((error) {
      return ApiResponse<bool>(error: true, errorMessage: error);
    });
  }

  Future<ApiResponse<PolicyGuidelineModel>?> getPolicyGuideline() {
    return http.get(Uri.parse(BASE_URL + "get-policy-guideline"),
        headers: {'Content-Type': 'application/json'}).then((value) {
      if (value.statusCode == 200) {
        var jsonData = json.decode(value.body);
        PolicyGuidelineModel policyGuidelineModel =
            PolicyGuidelineModel.fromJson(jsonData);
        return ApiResponse<PolicyGuidelineModel>(
            data: policyGuidelineModel, error: false);
      }
    }).catchError((error) {
      return ApiResponse<bool>(error: true, errorMessage: error);
    });
  }

  Future<ApiResponse<SurveyConfereneModel>?> getSurveyConference() {
    return http.get(Uri.parse(BASE_URL + "get-survey-conference"),
        headers: {'Content-Type': 'application/json'}).then((value) {
      if (value.statusCode == 200) {
        var jsonData = json.decode(value.body);
        SurveyConfereneModel surveyConfereneModel =
            SurveyConfereneModel.fromJson(jsonData);
        return ApiResponse<SurveyConfereneModel>(
            data: surveyConfereneModel, error: false);
      }
    }).catchError((error) {
      return ApiResponse<bool>(error: true, errorMessage: error);
    });
  }
}
