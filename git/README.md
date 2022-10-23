# Git Config

## References

[GitGuardian - 8 Easy Steps to Set Up Multiple GitHub Accounts](https://blog.gitguardian.com/8-easy-steps-to-set-up-multiple-git-accounts/)

## Setup

### Generate SSH keys

```shell
shh-keygen \
  -t ed25519 \
  -C "your_personal_email@example.com" \
  -f ~/.ssh/<personal_key>
```

### Create a SSH Config

```
# ~/.ssh/config

Host *
  IdentityFile ~/.ssh/<created_key>
```
