/**
 * Sample React Native App
 * https://github.com/facebook/react-native
 *
 * @format
 * @flow strict-local
 */

import React from 'react';
import type {Node} from 'react';
import {
  SafeAreaView,
  ScrollView,
  StatusBar,
  StyleSheet,
  Text,
  useColorScheme,
  View,
  NativeModules,
  Button,
} from 'react-native';

import {
  Colors,
  DebugInstructions,
  Header,
  LearnMoreLinks,
  ReloadInstructions,
} from 'react-native/Libraries/NewAppScreen';

const {TbtNavigation} = NativeModules;

const App: () => Node = () => {
  const isDarkMode = useColorScheme() === 'dark';

  const nativeSimpleMethod = () => {
    TbtNavigation.simpleMethod();
  };
  const nativeSimpleMethodReturns = () => {
    TbtNavigation.simpleMethodReturns(result => {
      alert(result);
    });
  };
  const nativeSimpleMethodWithParams = () => {
    TbtNavigation.simpleMethodWithParams('example', result => {
      alert(result);
    });
  };

  const backgroundStyle = {
    backgroundColor: isDarkMode ? Colors.darker : Colors.lighter,
  };

  return (
    <SafeAreaView style={backgroundStyle}>
      <StatusBar barStyle={isDarkMode ? 'light-content' : 'dark-content'} />

      <Button onPress={() => nativeSimpleMethod()} title="Simple Method" />
      <Button
        onPress={() => nativeSimpleMethodReturns()}
        title="Simple Method Returns"
      />
      <Button
        onPress={() => nativeSimpleMethodWithParams()}
        title="Simple Method With Params"
      />
    </SafeAreaView>
  );
};

const styles = StyleSheet.create({
  sectionContainer: {
    marginTop: 32,
    paddingHorizontal: 24,
  },
  sectionTitle: {
    fontSize: 24,
    fontWeight: '600',
  },
  sectionDescription: {
    marginTop: 8,
    fontSize: 18,
    fontWeight: '400',
  },
  highlight: {
    fontWeight: '700',
  },
});

export default App;
