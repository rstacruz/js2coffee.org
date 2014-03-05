# Js2coffee website

## new repository
js2coffee's new repository is moved to [js2coffee/js2coffee](https://github.com/js2coffee/js2coffee)

---

#### Made with [Proton](http://sinefunc.com/proton)

This is a Rack project, just use it as so. Alternatively, you can use Proton 
commands (`proton build` et al).

### Heroku setup log

    heroku create js2coffee --stack bamboo-mri-1.9.2
    heroku addons:add custom_domains
    heroku domains:add js2coffee.org
    git push heroku master

DNS records: ([reference](http://devcenter.heroku.com/articles/custom-domains)

    @ A 75.101.163.44
    @ A 75.101.145.87
    @ A 174.129.212.2
    www 301_redirect js2coffee.org
