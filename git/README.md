# Git Config

## References

[GitGuardian - 8 Easy Steps to Set Up Multiple GitHub Accounts](https://blog.gitguardian.com/8-easy-steps-to-set-up-multiple-git-accounts/)

## Setup

### Generate SSH keys

```shell
ssh-keygen \
  -t ed25519 \
  -C "109903144+kagenmi@users.noreply.github.com" \
  -f ~/.ssh/<personal_key>
```

### Create a SSH Config

```
# ~/.ssh/config

Host *
  IdentityFile ~/.ssh/<created_key>
```
