export interface htmltodataPlugin {
  echo(options: { value: string }): Promise<{ value: string }>;
}
