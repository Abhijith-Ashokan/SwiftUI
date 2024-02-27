//
//  TransactionRow.swift
//  ExpenseTracker
//
//  Created by Aoole on 22/02/24.
//

import SwiftUI

struct TransactionRow: View {
    var transaction: Transaction
    var body: some View {
        HStack {
            RoundedRectangle(cornerRadius: 20, style: /*@START_MENU_TOKEN@*/.continuous/*@END_MENU_TOKEN@*/)
                .fill(Color.iconColor.opacity(0.3))
                .frame(width: 44,height: 44)
            VStack(alignment: .center, spacing: 6) {
                
                // MARK: Transaction merchant
                Text(transaction.merchant)
                    .font(.subheadline)
                    .bold()
                    .lineLimit(1)
                
                // MARK: Transaction category
                Text(transaction.category)
                    .font(.footnote)
                    .opacity(0.7)
                    .lineLimit(1)
                
                // MARK: Transaction date
                Text(transaction.dateParsed,format: .dateTime.year().month().day())
                    .font(.footnote)
                    .foregroundColor(.secondary)
                
            }
            Spacer()
                // MARK: Transaction amount
            Text(transaction.signedAmount, format: .currency(code: "USD"))
                .bold()
                .foregroundColor(transaction.type == TransactionType.credit.rawValue ? Color.textColor : .primary)
        }
        .padding([.top, .bottom], 10)
    }
}

#Preview {
    TransactionRow(transaction: transactionPreviewData)
}
