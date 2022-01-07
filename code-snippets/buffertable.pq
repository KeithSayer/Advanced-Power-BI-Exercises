let
    Source = Excel.Workbook(File.Contents(FilePath&"SalesQuotes.xlsx"), null, true),
    SalesQuoteArchive_Sheet = Source{[Item="SalesQuoteArchive",Kind="Sheet"]}[Data],
    #"Promoted Headers" = Table.PromoteHeaders(SalesQuoteArchive_Sheet, [PromoteAllScalars=true]),
    #"Changed Type" = Table.TransformColumnTypes(#"Promoted Headers",{{"No.", type text}, {"Version", Int64.Type}, {"Modified Date", type date}, {"Customer No.", Int64.Type}, {"Amount", Int64.Type}}),
    #"Sorted Rows" = Table.Sort(#"Changed Type",{{"Version", Order.Descending}}),
    #"Buffer Table" = Table.Buffer(#"Sorted Rows"),
    #"Removed Duplicates" = Table.Distinct(#"Buffer Table", {"No."})
in
    #"Removed Duplicates"