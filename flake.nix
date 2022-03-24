{
  description = "Collection of flake templates";

  outputs = { self }: {
    templates = {
      base = {
        path = ./base;
        description = "Base flake with vscode configuration.";
      };
    };

    defaultTemplate = self.templates.base;
  };
}
