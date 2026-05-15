class ConsultationRouteExtra {
  const ConsultationRouteExtra({
    this.serviceName,
    this.isJobApplication = false,
    this.vacancyTitleKey,
  });

  final String? serviceName;
  final bool isJobApplication;
  final String? vacancyTitleKey;
}
