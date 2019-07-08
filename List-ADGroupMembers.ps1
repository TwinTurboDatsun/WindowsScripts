# List all AD groups
get-adgroup -filter * | sort name | select Name

# List members of a group
Get-AdGroupMember -identity "<AD group name>" | select name

# List groups a user is a member of
Get-ADPrincipalGroupMembership username | select name

