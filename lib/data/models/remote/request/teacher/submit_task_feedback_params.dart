/// Matches edutrack [SubmitFeedbackDto] (`reviewed` | `returned`).
enum TaskFeedbackReviewStatus {
  reviewed,
  returned,
}

class SubmitTaskFeedbackParams {
  SubmitTaskFeedbackParams({required this.feedback, required this.status});

  final String feedback;
  final TaskFeedbackReviewStatus status;

  Map<String, dynamic> toJson() => {
        'feedback': feedback,
        'status': status.name,
      };
}
