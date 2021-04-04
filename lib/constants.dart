import 'package:flutter/material.dart';

/// URLs
const String kBaseURL = 'https://app.anonaddy.com/api/v1';
const String kAccountDetailsURL = 'account-details';
const String kActiveAliasURL = 'active-aliases';
const String kAliasURL = 'alias';
const String kAliasesURL = 'aliases';
const String kEncryptedRecipient = 'encrypted-recipients';
const String kRecipientsURL = 'recipients';
const String kRecipientKeys = 'recipient-keys';
const kActiveUsernamesURL = 'active-usernames';
const kUsernamesURL = 'usernames';
const kCatchAllUsernameURL = 'catch-all-usernames';
const kDefaultRecipientURL = 'default-recipient';
const kDomainsURL = 'domains';

const kAnonAddySettingsAPIURL = 'https://app.anonaddy.com/settings';
const kDefaultAliasURL = 'https://app.anonaddy.com/settings';

const kAddyManagerRepo = 'https://github.com/KhalidWar/anonaddy';
const kAddyManagerIssue = 'https://github.com/KhalidWar/anonaddy/issues';
const kAddyManagerLicense =
    'https://github.com/KhalidWar/anonaddy/blob/master/LICENSE';
const kKhalidWarGithub = 'https://github.com/KhalidWar';
const kWillBrowningGithub = 'https://github.com/willbrowningme';

/// Official AnonAddy Code Strings
const kUUID = 'uuid';
const kRandomChars = 'random_characters';
const kCustom = 'custom';
const kRandomWords = 'random_words';

/// Official AnonAddy Messages
const kDeletedAliasText =
    'Deleted aliases reject all emails sent to them. However, they can be restored to start receiving emails again.';
const kDeleteAliasConfirmation =
    'Are you sure you want to delete this alias? You can restore this alias if you later change your mind. Once deleted, this alias will reject any emails sent to it.';
const kCreateNewAliasText =
    'Other aliases e.g. alias@khalidwar.anonaddy.com or .me can also be created automatically when they receive their first email.';
const kRestoreAliasText =
    'Are you sure you want to restore this alias? Once restored, this alias will be able to receive emails again.';
const kRemoveRecipientPublicKey = 'Remove recipient public key';
const kRemoveRecipientPublicKeyBody =
    'Are you sure you want to remove the public key for this recipient?\nIt will also be removed from any other recipients using the same key.';
const kDeleteRecipientDialogText =
    'Are you sure you want to delete this recipient?';
const kAddRecipientText =
    'Enter the individual email of the new recipient you\'d like to add.\n\nYou will receive an email with a verification link that will expire in one hour, you can click "Resend email" to get a new one.';
const kUpdateAliasRecipients =
    'Select the recipients for this alias. You can choose multiple recipients. Leave it empty if you would like to use the default recipient.';
const kAddNewUsernameText =
    'Please choose additional usernames carefully as you can only add a maximum of three. You cannot login with these usernames, only the one you originally signed up with.';
const kDeleteUsername =
    'Are you sure you want to delete this username? This will also delete all aliases associated with this username.\n\nYou will no longer be able to receive any emails at this username subdomain.\n\nThis will still count towards your additional username limit even once deleted.';
const kReachedUsernameLimit = 'You have reached your additional username limit';
const kReachedRecipientLimit = 'You have reached your recipient limit';
const kUpdateUsernameDefaultRecipient =
    'Select the default recipient for this username. This overrides the default recipient in your account settings.\n\nLeave it empty if you would like to use the default recipient in your account settings.';

/// Toast Messages
const kCopiedToClipboard = 'Copied to Clipboard';
const kAliasRestoredSuccessfully = 'Alias Restored Successfully';
const kFailedToRestoreAlias = 'Failed to Restore Alias';
const kAliasDeletedSuccessfully = 'Alias Deleted Successfully';
const kFailedToDeleteAlias = 'Failed to Delete Alias';
const kEncryptionEnabled = 'Encryption enabled';
const kFailedToEnableEncryption = 'Failed to Enable Encryption';
const kEncryptionDisabled = 'Encryption disabled';
const kFailedToDisableEncryption = 'Failed to disable encryption';
const kGPGKeyDeletedSuccessfully = 'GPG Key Deleted Successfully';
const kFailedToDeleteGPGKey = 'Failed to Delete GPG Key';
const kGPGKeyAddedSuccessfully = 'GPG Key Added Successfully';
const kFailedToAddGPGKey = 'Failed to Add GPG Key';
const kOnlyAvailableToPaid = 'Only available to paid users';
const kComingSoon = 'Coming Soon';

/// UI Strings
const kSearchHintText = 'Search aliases by email or description';
const kLoadingText = 'Loading';
const kDescriptionInputText = 'Description (optional)';
const kEnterLocalPart = 'Enter Local Part (no space or @)';
const kNoInternetConnection =
    'No Internet Connection.\nMake sure you\'re online.';
const kEditDescSuccessful = 'Description Updated Successfully';
const kEditDescFailed = 'Failed to update description';
const kGetAccessToken =
    'To access your AnonAddy account, you have to obtain an API Access Token.'
    '\n\nLogin to your AnonAddy account, head to settings, and navigate to API section.'
    '\n\nGenerate a new access token.'
    '\n\nAccess Token is a long string of alphabets, numbers, and special characters.'
    '\n\nPaste it here as is!';
const kPublicGPGKeyHintText =
    'Begins with \'-----BEGIN PGP PUBLIC KEY BLOCK-----\'';
const kEnterPublicKeyData =
    'Enter your PUBLIC key data in the text area below. Make sure to remove Comment: and Version:';
const kSignOutAlertDialog = 'Are you sure you want to sign out?';
const kUnverifiedRecipient =
    'Unverified recipient emails can NOT be set as default recipient for aliases.';
const kUpdateAliasRecipientFailed = 'Failed to update description';
const kUpdateAliasRecipientSuccessful = 'Successfully updated alias recipients';

/// Colors
const kBlueNavyColor = Color(0xFF19216C);
const kAccentColor = Color(0xFF62F4EB);

/// UI Decoration
const kTextFormFieldDecoration = InputDecoration(
  border: OutlineInputBorder(),
  focusedBorder:
      OutlineInputBorder(borderSide: BorderSide(color: kAccentColor)),
);
