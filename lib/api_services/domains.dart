String headlinesDomain =
    'https://newsapi.org/v2/top-headlines?country=us&apiKey=0a4de3c09b22407cbdfe14d90968628d';
String everythingDomain =
    ' https://newsapi.org/v2/everything?q=bitcoin&apiKey=0a4de3c09b22407cbdfe14d90968628d';
String headlineDomainBusiness =
    ' https://newsapi.org/v2/top-headlines?country=de&category=business&apiKey=0a4de3c09b22407cbdfe14d90968628d';
String headlineDomainentertainment =
    ' https://newsapi.org/v2/top-headlines?country=de&category=entertainment&apiKey=0a4de3c09b22407cbdfe14d90968628d';
String headlineDomaingeneral =
    ' https://newsapi.org/v2/top-headlines?country=de&category=general&apiKey=0a4de3c09b22407cbdfe14d90968628d';
String headlineDomainhealth =
    ' https://newsapi.org/v2/top-headlines?country=de&category=health&apiKey=0a4de3c09b22407cbdfe14d90968628d';
String headlineDomainscience =
    ' https://newsapi.org/v2/top-headlines?country=de&category=science&apiKey=0a4de3c09b22407cbdfe14d90968628d';
String headlineDomainsports =
    ' https://newsapi.org/v2/top-headlines?country=de&category=sports&apiKey=0a4de3c09b22407cbdfe14d90968628d';
String categoryDomain(String category) =>
    ' https://newsapi.org/v2/top-headlines?country=us&category=$category&apiKey=0a4de3c09b22407cbdfe14d90968628d';
String apiDomainsource(String source) =>
    'https://newsapi.org/v2/top-headlines?sources=$source&apiKey=0a4de3c09b22407cbdfe14d90968628d';
