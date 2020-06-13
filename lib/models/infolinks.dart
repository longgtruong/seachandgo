
import 'dart:collection';

class InfoLink {

  final String name;
  final String url;

  InfoLink({
    this.name,
    this.url
  });

}

// Links

final InfoLink terms = new InfoLink(
  name: "Terms & conditions",
  url: "https://www.tui.nl/corporate/nl/algemene-voorwaarden"
);

final InfoLink privacy = new InfoLink(
  name: "Privacy & cookies",
  url: "https://www.tui.nl/overons/privacybeleid/"
);

final InfoLink questions = new InfoLink(
  name: "Frequently asked questions",
  url: "https://www.tui.nl/klantenservice/"
);

List<InfoLink> links = [terms,privacy,questions];

