{
  description = "Collection of flake templates";

  outputs = { self }: {
    
    templates = {
      base = {
        path = ./base;
        description = "Flake with some boilerplate";
      };
    };

    defaultTemplate = self.templates.base;

  };
}
