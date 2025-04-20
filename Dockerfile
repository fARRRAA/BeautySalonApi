


# Базовый образ ASP.NET для рантайма
FROM mcr.microsoft.com/dotnet/aspnet:7.0 AS base
WORKDIR /app
EXPOSE 80

# Образ для сборки проекта
FROM mcr.microsoft.com/dotnet/sdk:7.0 AS build
WORKDIR /src
COPY ["BeautySalonApi.csproj", "./"]  # <-- Замени "MyApi.csproj" на имя своего .csproj файла
RUN dotnet restore "./BeautySalonApi.csproj"
COPY . .
RUN dotnet publish "BeautySalonApi.csproj" -c Release -o /app/publish

# Финальный образ
FROM base AS final
WORKDIR /app
COPY --from=build /app/publish .
ENTRYPOINT ["dotnet", "BeautySalonApi.dll"]  # <-- Замени "MyApi.dll" на своё имя DLL (совпадает с именем проекта)
