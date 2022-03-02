// Copyright (c) 2011-2014 The Bitcoin Core developers
// Distributed under the MIT software license, see the accompanying
// file COPYING or http://www.opensource.org/licenses/mit-license.php.

#ifndef AGROCOIN_QT_AGROCOINADDRESSVALIDATOR_H
#define AGROCOIN_QT_AGROCOINADDRESSVALIDATOR_H

#include <QValidator>

/** Base58 entry widget validator, checks for valid characters and
 * removes some whitespace.
 */
class AgroCoinAddressEntryValidator : public QValidator
{
    Q_OBJECT

public:
    explicit AgroCoinAddressEntryValidator(QObject *parent);

    State validate(QString &input, int &pos) const override;
};

/** AgroCoin address widget validator, checks for a valid agrocoin address.
 */
class AgroCoinAddressCheckValidator : public QValidator
{
    Q_OBJECT

public:
    explicit AgroCoinAddressCheckValidator(QObject *parent);

    State validate(QString &input, int &pos) const override;
};

#endif // AGROCOIN_QT_AGROCOINADDRESSVALIDATOR_H
