enum GPTModel {
  gpt4O('gpt-4o'),
  gpt4Turbo('gpt-4-turbo'),
  gpt4_0613('gpt-4-0613'),
  gpt4('gpt-4'),
  gpt35Turbo0125('gpt-3.5-turbo-0125'),
  gpt35Turbo('gpt-3.5-turbo'),
  gpt35Turbo0301('gpt-3.5-turbo-0301'),
  gpt35Turbo0613('gpt-3.5-turbo-0613'),
  gpt35Turbo16k0613('gpt-3.5-turbo-16k-0613'),
  gpt35Turbo16k('gpt-3.5-turbo-16k');

  const GPTModel(this.value);
  final String value;
}
