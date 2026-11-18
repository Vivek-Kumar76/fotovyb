class ApiEndpoints {
  ApiEndpoints._();

  static const String baseUrl = 'https://project-x-backend-232632423190.asia-south1.run.app';

  static const String creativeProfessionals = '/api/homepage/creative-professional';
  static const String spotlight = '/api/homepage/spotlight';
  static const String featuredProfessionals = '/api/homepage/featured';
  static const String prime = '/api/homepage/prime';
  static const String risingStars = '/api/homepage/rising-star';

  // ── Brand Opportunities (3-Tier Endpoints)
  static const String opportunitiesHighPriority = '/api/homepage/opportunities/high-priority';
  static const String opportunitiesBoosted = '/api/homepage/opportunities/boosted';
  static const String opportunitiesFeatured = '/api/homepage/opportunities/featured';

  // ── GIGs Feed Endpoints
  static const String gigsHighPriority = '/api/homepage/gigs/high-priority';
  static const String gigsProMaster = '/api/homepage/gigs/pro-master';
  static const String gigsFeatured = '/api/homepage/gigs/featured';

  // ── Professionals Page Section Endpoints
  static const String professionalsSpotlight = '/api/professionals?section=spotlight';
  static const String professionalsFeatured = '/api/professionals?section=featured';
  static const String professionalsPrime = '/api/professionals?section=prime';
  static const String professionalsRisingStars = '/api/professionals?section=rising-star';

  // ── Standalone Opportunities Page Section Endpoints
  static const String opportunitiesPageBase = '/api/opportunities';
  static const String opportunitiesPageHighPriority = '/api/opportunities?section=high-priority';
  static const String opportunitiesPageBoosted = '/api/opportunities?section=boosted';
  static const String opportunitiesPageFeatured = '/api/opportunities?section=featured';

 // ── Standalone GIGs Page Section Endpoints
  static const String gigsPageBase = '/api/gigs';
  static const String gigsPageHighPriority = '/api/gigs?section=high-priority';
  static const String gigsPageProMaster = '/api/gigs?section=pro-master';
  static const String gigsPageFeatured = '/api/gigs?section=featured';
  static const String gigsPageExplore = '/api/gigs?section=explore'; 
}