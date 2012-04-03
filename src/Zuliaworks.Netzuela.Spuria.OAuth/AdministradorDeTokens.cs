﻿namespace Zuliaworks.Netzuela.Spuria.ServidorOAuth
{
    using System;
    using System.Collections.Generic;
    using System.Linq;
    using System.Web;

    using DotNetOpenAuth.OAuth.ChannelElements;     // IServiceProviderTokenManager

    public class AdministradorDeTokens : IServiceProviderTokenManager
    {
        #region Constructores

        public AdministradorDeTokens() 
        { 
        }

        #endregion

        #region Implementación de interfaces

        public IServiceProviderAccessToken GetAccessToken(string token)
        {
            throw new NotImplementedException();
        }

        public IConsumerDescription GetConsumer(string consumerKey)
        {
            throw new NotImplementedException();
        }

        public IServiceProviderRequestToken GetRequestToken(string token)
        {
            throw new NotImplementedException();
        }

        public bool IsRequestTokenAuthorized(string requestToken)
        {
            throw new NotImplementedException();
        }

        public void UpdateToken(IServiceProviderRequestToken token)
        {
            throw new NotImplementedException();
        }

        public void ExpireRequestTokenAndStoreNewAccessToken(string consumerKey, string requestToken, string accessToken, string accessTokenSecret)
        {
            throw new NotImplementedException();
        }

        public string GetTokenSecret(string token)
        {
            throw new NotImplementedException();
        }

        public TokenType GetTokenType(string token)
        {
            throw new NotImplementedException();
        }

        public void StoreNewRequestToken(DotNetOpenAuth.OAuth.Messages.UnauthorizedTokenRequest request, DotNetOpenAuth.OAuth.Messages.ITokenSecretContainingMessage response)
        {
            throw new NotImplementedException();
        }

        #endregion
    }
}