// ignore: file_names

class JobModel {
  JobPost? data = JobPost();
  String error = "";

  JobModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] == null) {
      data = json["data"];
    } else {
      data = JobPost.fromJson(json);
    }
    error = json["error"];
  }
}

class JobPost {
  ActivityOnTheJob activityOnTheJob = ActivityOnTheJob();
  List<dynamic> attachments = [];
  ClientDetail clientDetail = ClientDetail();
  String clientLookingDeveloper = "";
  List<dynamic> clientRecentHistory = [];
  String connectsRequire = "";
  String description = "";
  bool fixedJob = false;
  String fixedPrice = "";
  bool hourlyJob = false;
  String hourlyPrice = "";
  bool paymentVerified = false;
  String postedJobTitle = "";
  String postedOn = "";
  String projectDuration = "";
  String projectType = "";
  List<dynamic> questionAskedByClient = [];
  String skillsAndExpertise = "";

  JobPost();

  JobPost.fromJson(Map<String, dynamic> json) {
    activityOnTheJob =
        ActivityOnTheJob.fromJson(json["data"]['ActivityOnTheJob'] ?? {});
    attachments = json["data"]['Attachments'] ?? [];
    clientDetail = ClientDetail.fromJson(json["data"]['ClientDetail'] ?? {});
    clientLookingDeveloper = json["data"]['ClientLookingDeveloper'];
    clientRecentHistory = json["data"]['ClientRecentHistory'] ?? [];
    connectsRequire = json["data"]['ConnectsRequire'] ?? "";
    description = json["data"]['Description'] ?? "";
    fixedJob = json["data"]['FixedJob'] ?? false;
    fixedPrice = json["data"]['FixedPrice'] ?? "";
    hourlyJob = json["data"]['HourlyJob'] ?? false;
    hourlyPrice = json["data"]['HourlyPrice'] ?? "";
    paymentVerified = json["data"]['PaymentVerified'] ?? false;
    postedJobTitle = json["data"]['PostedJobTitle'] ?? "";
    postedOn = json["data"]['PostedOn'] ?? "";
    projectDuration = json["data"]['ProjectDuration'] ?? "";
    projectType = json["data"]['ProjectType'] ?? "";
    questionAskedByClient = json["data"]['QuestionAskedByClient'] ?? [];
    skillsAndExpertise = json["data"]['SkillsAndExpertise'] ?? "";
  }

  Map<String, dynamic> toJson() {
    return {
      'ActivityOnTheJob': activityOnTheJob.toJson(),
      'Attachments': attachments,
      'ClientDetail': clientDetail.toJson(),
      'ClientLookingDeveloper': clientLookingDeveloper,
      'ClientRecentHistory': clientRecentHistory,
      'ConnectsRequire': connectsRequire,
      'Description': description,
      'FixedJob': fixedJob,
      'FixedPrice': fixedPrice,
      'HourlyJob': hourlyJob,
      'HourlyPrice': hourlyPrice,
      'PaymentVerified': paymentVerified,
      'PostedJobTitle': postedJobTitle,
      'PostedOn': postedOn,
      'ProjectDuration': projectDuration,
      'ProjectType': projectType,
      'QuestionAskedByClient': questionAskedByClient,
      'SkillsAndExpertise': skillsAndExpertise,
    };
  }
}

class ClientDetail {
  String city = "";
  String country = "";
  String hireRate = "";
  String jobsPosted = "";
  bool paymentVerified = false;
  String time = "";
  String totalSpent = "";
  String clientReviews = "";

  ClientDetail();

  ClientDetail.fromJson(Map<String, dynamic> json) {
    city = json['City'] ?? "";
    country = json['Country'] ?? "";
    hireRate = json['HireRate'] ?? "";
    jobsPosted = json['JobsPosted'] ?? "";
    paymentVerified = json['PaymentVerified'] ?? false;
    time = json['Time'] ?? "";
    totalSpent = json['TotalSpent'] ?? "";
    clientReviews = json['clientReviews'] ?? "";
  }

  Map<String, dynamic> toJson() {
    return {
      'City': city,
      'Country': country,
      'HireRate': hireRate,
      'JobsPosted': jobsPosted,
      'PaymentVerified': paymentVerified,
      'Time': time,
      'TotalSpent': totalSpent,
      'clientReviews': clientReviews,
    };
  }
}

class ActivityOnTheJob {
  String interviewing = "";
  String invitesSent = "";
  String lastViewedByClient = "";
  String proposals = "";
  String unansweredInvites = "";

  ActivityOnTheJob();

  ActivityOnTheJob.fromJson(Map<String, dynamic> json) {
    interviewing = json['Interviewing'] ?? "";
    invitesSent = json['InvitesSent'] ?? "";
    lastViewedByClient = json['Last_viewed_by_client'] ?? "";
    proposals = json['Proposals'] ?? "";
    unansweredInvites = json['Unanswered_invites'] ?? "";
  }

  Map<String, dynamic> toJson() {
    return {
      'Interviewing': interviewing,
      'InvitesSent': invitesSent,
      'Last_viewed_by_client': lastViewedByClient,
      'Proposals': proposals,
      'Unanswered_invites': unansweredInvites,
    };
  }
}
