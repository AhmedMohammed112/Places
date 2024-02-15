class AutocompletePredection 
{
  final String? description; 
  final StructuredFormatting? structuredFormatting; 
  final String? placeId;
  final String? reference; 

  AutocompletePredection({
    this.description, 
    this.structuredFormatting, 
    this.placeId, 
    this.reference
  }); 

  factory AutocompletePredection.fromJson(Map<String, dynamic> json) 
  {
    return AutocompletePredection(
      description: json['description'], 
      structuredFormatting: json['structured_formatting'] != null ? StructuredFormatting.fromJson(json['structured_formatting']) : null,
      placeId: json['place_id'], 
      reference: json['reference']
    ); 
  }
  
} 

class StructuredFormatting 
{
  final String? mainText; 
  final String? secondaryText; 

  StructuredFormatting({
    this.mainText, 
    this.secondaryText
  });  

  factory StructuredFormatting.fromJson(Map<String, dynamic> json) 
  {
    return StructuredFormatting(
      mainText: json['main_text'], 
      secondaryText: json['secondary_text']
    ); 
  }
}