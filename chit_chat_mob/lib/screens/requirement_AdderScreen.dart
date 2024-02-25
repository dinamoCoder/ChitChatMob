// ignore: file_names

import 'package:any_link_preview/any_link_preview.dart';
import 'package:chit_chat_mob/Models/Response/Job_Post.dart';
import 'package:chit_chat_mob/Services/job_service.dart';
import 'package:chit_chat_mob/widgets/load_spinner.dart';
import 'package:flutter/material.dart';

class RequirementAddScreen extends StatefulWidget {
  const RequirementAddScreen({super.key});
  @override
  State<StatefulWidget> createState() => _RequirementAddScreen();
}

class _RequirementAddScreen extends State<RequirementAddScreen> {
  final JobService _jobService = JobService();
  // _RequirementAddScreen() {
  //   selectedPayment = payment[1];
  // }
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _countryController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _hireRateController = TextEditingController();
  final TextEditingController _jobsPostedController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();
  final TextEditingController _totalSpentController = TextEditingController();
  final TextEditingController _interviewingController = TextEditingController();
  final TextEditingController _invitesSentController = TextEditingController();
  // final TextEditingController _postedOnController = TextEditingController();
  // final TextEditingController _projectDurationController =
  //     TextEditingController();
  // final TextEditingController _projectTypeController = TextEditingController();
  // final TextEditingController _skillsController = TextEditingController();
  final TextEditingController _lastViewedByClientController =
      TextEditingController();
  final TextEditingController _unansweredInvitesController =
      TextEditingController();

  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _urlController = TextEditingController();

  String? selectedPayment = "";
  String? selectedRating = "";
  String? selectedProposalsSend = "";
  String? selectedWorkType = "";
  TextEditingController selectedPaymentController = TextEditingController();
  List<String> payment = ['Verified', 'UnVerified'];
  List<String> workType = ['Fixed Job', 'Hourly Job'];
  List<String> rating = ['1.0', '2.0', '3.0', '4.0', '5.0'];
  List<dynamic> attachedDocument = [];
  List<dynamic> clientHistory = [];
  List<String> proposalsListSend = [
    'Less than 5',
    '5 to 10',
    '10 to 20',
    '20 to 30',
    '30 to 40',
    '50+'
  ];
  bool isLoading = false;
  //String logo = "";
  // this method is  used for getting the documents that will attached by the client.
  // _openGallery() async {
  //   if (logo != "") {
  //     ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
  //       content: Text("Your already selected an image"),
  //       showCloseIcon: true,
  //     ));
  //     return;
  //   }
  //   final returnedImage =
  //       await ImagePicker().;
  //   if (returnedImage != null) {
  //     ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
  //       content: Text("Your image will be selected"),
  //       showCloseIcon: true,
  //     ));
  //     var imageData = await io.File(returnedImage.path).readAsBytes();
  //     logo = base64Encode(imageData);
  //   }
  // }
  setJobScrapperData(JobModel jobData) {
    setState(() {
      isLoading = false;
      // here we will set the input box with the value that we get from the job post.
      _titleController.text = jobData.data?.postedJobTitle ?? "";
      _descriptionController.text = jobData.data?.description ?? "";
      // client detail set here.........................................
      selectedPayment =
          jobData.data!.clientDetail.paymentVerified ? payment[0] : payment[1];
      _countryController.text = jobData.data!.clientDetail.country;
      selectedRating = rating[rating.indexOf(
          '${jobData.data!.clientDetail.clientReviews.substring(0, 1)}.0')];
      _cityController.text = jobData.data!.clientDetail.city;
      _hireRateController.text = jobData.data!.clientDetail.hireRate;
      _jobsPostedController.text = jobData.data!.clientDetail.jobsPosted;
      _timeController.text = jobData.data!.clientDetail.time;
      _totalSpentController.text = jobData.data!.clientDetail.totalSpent;

      // activity of the client set
      _interviewingController.text =
          jobData.data!.activityOnTheJob.interviewing;
      _invitesSentController.text = jobData.data!.activityOnTheJob.invitesSent;
      _lastViewedByClientController.text =
          jobData.data!.activityOnTheJob.lastViewedByClient;
      selectedProposalsSend = proposalsListSend[
          proposalsListSend.indexOf(jobData.data!.activityOnTheJob.proposals)];
      _unansweredInvitesController.text =
          jobData.data!.activityOnTheJob.unansweredInvites;

      // set the job type like fixed job or hourly job
      // here if fixed job is true then the type is fixed job otherwise hourly job will be set.
      selectedWorkType = jobData.data!.fixedJob && !jobData.data!.hourlyJob
          ? workType[0]
          : workType[1];
      // we will set the price of the job.
      _priceController.text = jobData.data!.fixedJob && !jobData.data!.hourlyJob
          ? jobData.data!.fixedPrice
          : jobData.data!.hourlyPrice;
      clientHistory = jobData.data!.clientRecentHistory;
      attachedDocument = jobData.data!.attachments;
      // _postedOnController.text = jobData.data!.postedOn;
      // _skillsController.text = jobData.data!.skillsAndExpertise;
      // _projectTypeController.text = jobData.data!.projectType;
      // _projectDurationController.text = jobData.data!.projectDuration;
    });

    //set the client paymnent is verified or not ...............

    // _.text = jobData.data?.postedJobTitle??"";
    // _titleController.text = jobData.data?.postedJobTitle??"";
    // _titleController.text = jobData.data?.postedJobTitle??"";
    // _titleController.text = jobData.data?.postedJobTitle??"";
    // _titleController.text = jobData.data?.postedJobTitle??"";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Requirement'),
        backgroundColor: Colors.orangeAccent,
        shadowColor: Colors.black,
        toolbarHeight: 60.60,
        titleTextStyle: const TextStyle(color: Colors.white, fontSize: 22.5),
        foregroundColor: Colors.white,
      ),
      resizeToAvoidBottomInset: true,
      body: Stack(children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextFormField(
                controller: _urlController,
                decoration: const InputDecoration(labelText: 'Job URL'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter Job URL';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () async {
                  // Set isLoading to true to show the loader
                  setState(() {
                    isLoading = true;
                    // Close the keyboard when the button is pressed
                    FocusScope.of(context).unfocus();
                  });
                  var data = await _jobService.scrapJob(_urlController.text);
                  if (data?.error != "") {
                    setState(() {
                      isLoading = false;
                      // remove the wrong url from the input ....
                      _urlController.text = "";
                      // we will show the snackbar and set the isloading property to false.
                      final snackBar = SnackBar(
                        content: Text(
                          data?.error,
                          style: const TextStyle(
                              fontSize: 15, color: Colors.white),
                        ),
                        duration: const Duration(seconds: 8),
                        backgroundColor: Colors.red,
                        showCloseIcon: true, // Set custom duration here
                      );

                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    });
                  } else {
                    setState(() {
                      isLoading = false;
                    });
                    setJobScrapperData(data);
                  }
                },
                child: const Text('Parse the Job'),
              ),
              const SizedBox(height: 16.0),
              Expanded(
                child: ListView(children: [
                  Column(
                    children: [
                      Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            TextFormField(
                              controller: _titleController,
                              decoration:
                                  const InputDecoration(labelText: 'Title'),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter Title';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 16.0),
                            TextFormField(
                              controller: _descriptionController,
                              decoration: const InputDecoration(
                                  labelText: 'Description'),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your Description';
                                } else if (value.length < 10) {
                                  return 'Please enter a Description that contains 10 words or greter';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 16.0),
                            Container(
                              width: MediaQuery.sizeOf(context).width,
                              padding: const EdgeInsets.fromLTRB(
                                  25.0, 10.0, 25.0, 10.0),
                              color: const Color.fromARGB(255, 177, 156, 126),
                              child: const Text(
                                "Client Info",
                                style: TextStyle(
                                    fontSize: 21, color: Colors.white),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            const SizedBox(height: 16.0),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                DropdownMenu<String>(
                                  width:
                                      MediaQuery.of(context).size.width / 2 + 3,
                                  initialSelection: selectedPayment,
                                  // requestFocusOnTap is enabled/disabled by platforms when it is null.
                                  // On mobile platforms, this is false by default. Setting this to true will
                                  // trigger focus request on the text field and virtual keyboard will appear
                                  // afterward. On desktop platforms however, this defaults to true.
                                  label: const Text('Select Payment'),
                                  onSelected: (String? payment) {
                                    setState(() {
                                      selectedPayment = payment ?? "";
                                    });
                                  },
                                  dropdownMenuEntries: payment
                                      .map<DropdownMenuEntry<String>>(
                                          (String payment) {
                                    return DropdownMenuEntry<String>(
                                      value: payment,
                                      label: payment,
                                      style: MenuItemButton.styleFrom(
                                        foregroundColor:
                                            selectedPayment == payment
                                                ? Colors.amber
                                                : null,
                                      ),
                                    );
                                  }).toList(),
                                ),
                                const SizedBox(width: 8),
                                DropdownMenu<String>(
                                  initialSelection: selectedRating,
                                  // requestFocusOnTap is enabled/disabled by platforms when it is null.
                                  // On mobile platforms, this is false by default. Setting this to true will
                                  // trigger focus request on the text field and virtual keyboard will appear
                                  // afterward. On desktop platforms however, this defaults to true.
                                  label: const Text('Client Rating'),
                                  onSelected: (String? rating) {
                                    setState(() {
                                      selectedRating = rating ?? "";
                                    });
                                  },
                                  dropdownMenuEntries: rating
                                      .map<DropdownMenuEntry<String>>(
                                          (String rating) {
                                    return DropdownMenuEntry<String>(
                                      value: rating,
                                      label: rating,
                                      style: MenuItemButton.styleFrom(
                                        foregroundColor:
                                            selectedRating == rating
                                                ? Colors.amber
                                                : null,
                                      ),
                                    );
                                  }).toList(),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16.0),
                            TextFormField(
                              controller: _countryController,
                              decoration:
                                  const InputDecoration(labelText: 'Country'),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter country';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 16.0),
                            TextFormField(
                              controller: _cityController,
                              decoration:
                                  const InputDecoration(labelText: 'City'),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter city';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 16.0),
                            TextFormField(
                              controller: _jobsPostedController,
                              decoration: const InputDecoration(
                                  labelText: 'Job Posted'),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter job posted by client ';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 16.0),
                            TextFormField(
                              controller: _hireRateController,
                              decoration:
                                  const InputDecoration(labelText: 'Hire Rate'),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter hire rate of client ';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 16.0),
                            TextFormField(
                              controller: _timeController,
                              decoration:
                                  const InputDecoration(labelText: 'Time'),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter time of client';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 16.0),
                            TextFormField(
                              controller: _totalSpentController,
                              decoration: const InputDecoration(
                                  labelText: 'Total Spent'),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter total spent of client';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 16.0),
                            Container(
                              width: MediaQuery.sizeOf(context).width,
                              padding: const EdgeInsets.fromLTRB(
                                  25.0, 10.0, 25.0, 10.0),
                              color: const Color.fromARGB(255, 177, 156, 126),
                              child: const Text(
                                "Activity of client",
                                style: TextStyle(
                                    fontSize: 21, color: Colors.white),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            const SizedBox(height: 16.0),
                            TextFormField(
                              controller: _interviewingController,
                              decoration: const InputDecoration(
                                  labelText: 'Interviewing People'),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter interviewing client';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 16.0),
                            TextFormField(
                              controller: _invitesSentController,
                              decoration: const InputDecoration(
                                  labelText: 'Invite Sent'),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter invite sent by client ';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 16.0),
                            TextFormField(
                              controller: _unansweredInvitesController,
                              decoration: const InputDecoration(
                                  labelText: 'Unanswered Invites'),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter unanswered invite by the  client';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 16.0),
                            TextFormField(
                              controller: _unansweredInvitesController,
                              decoration: const InputDecoration(
                                  labelText: 'Last Viewed By Client'),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter last viewed by the client';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 16.0),
                            DropdownMenu<String>(
                              width:
                                  MediaQuery.of(context).size.width * 6 / 6.5,
                              initialSelection: selectedProposalsSend,
                              // requestFocusOnTap is enabled/disabled by platforms when it is null.
                              // On mobile platforms, this is false by default. Setting this to true will
                              // trigger focus request on the text field and virtual keyboard will appear
                              // afterward. On desktop platforms however, this defaults to true.
                              label: const Text('Proposals send'),
                              onSelected: (String? propSend) {
                                setState(() {
                                  selectedProposalsSend = propSend ?? "";
                                });
                              },
                              dropdownMenuEntries: proposalsListSend
                                  .map<DropdownMenuEntry<String>>(
                                      (String propSend) {
                                return DropdownMenuEntry<String>(
                                  value: propSend,
                                  label: propSend,
                                  style: MenuItemButton.styleFrom(
                                    foregroundColor:
                                        selectedProposalsSend == propSend
                                            ? Colors.amber
                                            : null,
                                  ),
                                );
                              }).toList(),
                            ),
                            const SizedBox(height: 16.0),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                DropdownMenu<String>(
                                  width:
                                      MediaQuery.of(context).size.width / 2.8,
                                  initialSelection: selectedPayment,
                                  // requestFocusOnTap is enabled/disabled by platforms when it is null.
                                  // On mobile platforms, this is false by default. Setting this to true will
                                  // trigger focus request on the text field and virtual keyboard will appear
                                  // afterward. On desktop platforms however, this defaults to true.
                                  label: const Text('Job Type'),
                                  onSelected: (String? workType) {
                                    setState(() {
                                      selectedWorkType = workType ?? "";
                                    });
                                  },
                                  dropdownMenuEntries: workType
                                      .map<DropdownMenuEntry<String>>(
                                          (String workType) {
                                    return DropdownMenuEntry<String>(
                                      value: workType,
                                      label: workType,
                                      style: MenuItemButton.styleFrom(
                                        foregroundColor:
                                            selectedWorkType == workType
                                                ? Colors.amber
                                                : null,
                                      ),
                                    );
                                  }).toList(),
                                ),
                                const SizedBox(width: 8),
                                SizedBox(
                                  width: MediaQuery.of(context).size.width / 2,
                                  child: TextFormField(
                                    controller: _priceController,
                                    decoration: const InputDecoration(
                                        labelText: 'Project Price'),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter project price';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16.0),
                            Container(
                              width: MediaQuery.sizeOf(context).width,
                              padding: const EdgeInsets.fromLTRB(
                                  25.0, 10.0, 25.0, 10.0),
                              color: const Color.fromARGB(255, 177, 156, 126),
                              child: const Text(
                                "Client History",
                                style: TextStyle(
                                    fontSize: 21, color: Colors.white),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            const SizedBox(height: 16.0),
                            ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: clientHistory.length,
                              itemBuilder: (context, index) {
                                return ListTile(
                                  leading: const Icon(Icons
                                      .circle), // You can customize the bullet icon
                                  title: Text(clientHistory[index]),
                                );
                              },
                            ),
                            const SizedBox(height: 16.0),
                            Container(
                              width: MediaQuery.sizeOf(context).width,
                              padding: const EdgeInsets.fromLTRB(
                                  25.0, 10.0, 25.0, 10.0),
                              color: const Color.fromARGB(255, 177, 156, 126),
                              child: const Text(
                                "Attached Document",
                                style: TextStyle(
                                    fontSize: 21, color: Colors.white),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: attachedDocument.length,
                                itemBuilder: (context, index) {
                                  return AnyLinkPreview(
                                    link: attachedDocument[index],
                                    displayDirection:
                                        UIDirection.uiDirectionHorizontal,
                                    cache: const Duration(hours: 1),
                                    backgroundColor: Colors.grey[300],

                                    // Widget to display when there's an error fetching preview
                                    errorWidget: Container(
                                      color: Colors.grey[300],
                                      child: Text('Oops!'),
                                    ),
                                  );
                                }),
                            const SizedBox(height: 16.0),
                            ElevatedButton(
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  // Form is valid, process the data
                                  String name = _titleController.text;
                                  String email = _descriptionController.text;
                                  String country = _countryController.text;
                                  String price = _priceController.text;

                                  // Do something with the form data
                                  print(
                                      'Name: $name, Email: $email, country : $country');
                                }
                              },
                              child: const Text('Submit'),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ]),
              ),
            ],
          ),
        ),
        LoadSpinner(show: isLoading)
      ]),
    );
  }
}
