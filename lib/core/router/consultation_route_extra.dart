class ConsultationRouteExtra {
  const ConsultationRouteExtra({
    this.serviceName,
    this.isJobApplication = false,
    this.vacancyTitleKey,
    this.serviceTitleKey,
  });

  final String? serviceName;
  final bool isJobApplication;
  final String? vacancyTitleKey;
  final String? serviceTitleKey;
}
