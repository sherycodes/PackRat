import { useSelector } from 'react-redux'

import { Platform } from 'react-native'

import { Stack as Header, useRootNavigation } from 'expo-router'

import { darkTheme, theme } from '../theme'

import { Box } from 'native-base'

import LandingPage from '../components/landing_page'

import Dashboard from '../screens/dashboard'
import useTheme from '../hooks/useTheme'
import { useEffect, useState } from 'react'

export default function Index() {
  const { enableDarkMode, enableLightMode, isDark, isLight, currentTheme = theme } = useTheme()

  const user = useSelector((state) => state.auth.user)

  const mutualStyles = {
    backgroundColor: currentTheme.colors.background,
    flex: 1,
  }

  return (
    <>
      <Box style={mutualStyles}>{!user ? <LandingPage /> : <Dashboard />}</Box>
    </>
  )
}
